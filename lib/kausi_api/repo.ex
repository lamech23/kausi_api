defmodule KausiApi.Repo do
  use Ecto.Repo,
    otp_app: :kausi_api,
    adapter: Ecto.Adapters.MyXQL
end
