defmodule KausiApiWeb.DetailsController do
  use KausiApiWeb, :controller

  alias KausiApi.Details
  alias KausiApi.Details.Detail
  alias Arc.Store

  action_fallback KausiApiWeb.FallbackController

  def fetch_details(conn, _params) do
     case Details.list_details do 

      [] -> {:error,  "no details found"} 
      details ->
        conn
        |> put_status(:ok)
        |> render(:index, details: details)
  
     end
   end


  def create(conn,   detail_params) do
    IO.inspect(detail_params)
    with {:ok, %Detail{} = detail} <- Details.create_detail(detail_params),
         {:ok, file} <- Arc.Store_file.store(detail_params["image"])do
        #  {:ok, renamed_file} <- rename_file(file) do
      changeset = Detail.changeset(detail, detail_params["image"])
      case Repo.insert(changeset) do
        {:ok, detail} ->
          conn
          |> put_status(:created)
          |> put_resp_header("location", ~p"/api/details/#{detail}")
          |> render(:show, detail: detail)
        {:error, _} ->
          raise "Failed to create details"
      end
    end
  end
  
  defp rename_file(file) do
    hashed_file_name = Pbkdf2.hash(file.filename, :sha)
    file_ext = Path.extname(file.filename)
    new_filename = "#{hashed_file_name}#{file_ext}"
    renamed_file = Arc.File.rename(file, new_filename)
    {:ok, renamed_file}
  rescue
    exception -> {:error, exception}
  end




  def update(conn, %{"id" => id, "detail" => detail_params}) do
    detail = Details.get_detail!(id)

    with {:ok, %Detail{} = detail} <- Details.update_detail(detail, detail_params) do
      render(conn, :show, detail: detail)
    end
  end

  def delete(conn, %{"id" => id}) do
    detail = Details.get_detail!(id)

    with {:ok, %Detail{}} <- Details.delete_detail(detail) do
      send_resp(conn, :no_content, "")
    end
  end
end
