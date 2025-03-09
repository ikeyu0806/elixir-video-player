defmodule VideoPlayer.Youtube.Channel do
  use Ecto.Schema
  import Ecto.Changeset

  schema "channels" do
    field :channel_id, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(channel, attrs) do
    channel
    |> cast(attrs, [:channel_id])
    |> validate_required([:channel_id])
  end
end
