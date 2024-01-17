defmodule HelloHtmx.Repo do
  use Ecto.Repo,
    otp_app: :hello_htmx,
    adapter: Ecto.Adapters.Postgres
end
