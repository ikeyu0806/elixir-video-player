defmodule VideoPlayer.Repo.Migrations.CreateChannels do
  use Ecto.Migration

  def change do
    create table(:channels) do
      add :channel_id, :string

      timestamps(type: :utc_datetime)
    end
  end
end
