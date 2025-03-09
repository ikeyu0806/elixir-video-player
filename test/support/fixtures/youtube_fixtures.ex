defmodule VideoPlayer.YoutubeFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `VideoPlayer.Youtube` context.
  """

  @doc """
  Generate a channel.
  """
  def channel_fixture(attrs \\ %{}) do
    {:ok, channel} =
      attrs
      |> Enum.into(%{
        channel_id: "some channel_id"
      })
      |> VideoPlayer.Youtube.create_channel()

    channel
  end
end
