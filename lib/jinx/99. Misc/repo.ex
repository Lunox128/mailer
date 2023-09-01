defmodule Jinx.Repo do
  use Ecto.Repo,
    otp_app: :jinx,
    adapter: Ecto.Adapters.Postgres
end
