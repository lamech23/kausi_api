defmodule KausiApiWeb.Router do
  use KausiApiWeb, :router
  use Plug.ErrorHandler

  defp handle_error(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  defp handle_error(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  if Mix.env == :dev do
  forward "/sent_emails", Bamboo.EmailPreviewPlug
  end

  scope "/api", KausiApiWeb do
    pipe_through :api

    post "accounts/signup", AccountController, :create
    post "accounts/login", AccountController, :sign_in
    get "accounts/all_accounts", AccountController, :index
    delete "accounts/delete_account/:id", AccountController, :delete
    post "accounts/forgot_password/", AccountController, :forgot_password
    post "details/add_image_details/", DetailsController, :create
    get "details/all_details", DetailsController, :fetch_details



    # if Mix.env() == :dev do
    #   get "/preview_emails/:type", PreviewEmailController, :show
    # end
  end
end
