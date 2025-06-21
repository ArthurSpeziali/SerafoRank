defmodule SeraphoRank.Repo do
  use Ecto.Repo,
    otp_app: :serapho_rank,
    adapter: Ecto.Adapters.Postgres
end
