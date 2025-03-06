defmodule VideoPlayer.Repo do
  use Ecto.Repo,
    otp_app: :video_player,
    adapter: Ecto.Adapters.Postgres
end
