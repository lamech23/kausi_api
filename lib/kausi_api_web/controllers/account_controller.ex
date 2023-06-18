defmodule KausiApiWeb.AccountController do
  use KausiApiWeb, :controller
import Bamboo.Email
  alias KausiApi.{Accounts, Accounts.Account, Users, Users.User}
  alias KausiApiWeb.{Auth.Guardian, Auth.ErrorResponse, Auth.Mailer, Auth.Email}


  action_fallback KausiApiWeb.FallbackController

  def index(conn, _params) do
     accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end
  



  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params),
    {:ok, token, _claims} <- Guardian.encode_and_sign(account),
    {:ok, %User{} = _user} <- Users.create_user(account, account_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/accounts/#{account}")
      |> render(:show, %{account: account, token: token })
    end
  end

  def sign_in(conn, %{"email" => email, "hash_password" => hash_password}) do
    case Guardian.authenticate(email, hash_password) do
      {:ok, account, token} ->
        conn
        |> put_status(:ok)
        |> render(:token, %{account: account, token: token} )

        {:error, :unauthorized} -> raise ErrorResponse.Unauthorized, message: "Email or password incorrect"
    end


  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    render(conn, :show, account: account)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{} = account} <- Accounts.update_account(account, account_params) do
      render(conn, :show, account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    with {:ok, %Account{}} <- Accounts.delete_account(account) do

      send_resp(conn, :no_content, "")
    end
  end


  def forgot_password(conn, %{"account" => %{"email" => email }}) do
    account = Accounts.get_account_by_email(email)
    
    case account do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Email address not found."})
        _ ->
          reset_link = "http://localhost:4000/api/accounts/forgot_password/" 

          email_body = generate_reset_password_email(reset_link)

          # email_params = %{
          #   to: email,
          #   subject: "Reset your password",
          #   body: "reset boy"
          # }

         Email.send_email(%{email: email}) 

      conn
      |> put_status(:ok)
      |> json(%{message: "Password reset instructions sent to #{email} ."})


  end
end

defp generate_reset_password_email(reset_link) do
  "Click the link below to reset your password:\n\n#{reset_link}\n\nIf you did not request a password reset, please ignore this email."
end



end
