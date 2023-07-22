defmodule Peticeni.Repo do
  use Ecto.Repo,
    otp_app: :peticeni,
    adapter: Ecto.Adapters.Postgres

  use Ecto.SoftDelete.Repo
end
