defmodule VideoPlayerWeb.VideoController do
  use VideoPlayerWeb, :controller
  alias VideoPlayer.Youtube.Channel
  alias VideoPlayer.Youtube.Video
  alias VideoPlayer.Repo
  import Ecto.Query

  def index(conn, _params) do
    channel_ids = Repo.all(from c in Channel, select: c.channel_id)
    videos = channel_ids
      |> Enum.map(&VideoPlayer.Youtube.get_channel_videos/1)
      |> Enum.reduce({:ok, []}, fn
        {:ok, vids}, {:ok, acc} -> {:ok, acc ++ vids}
        {:error, msg}, _ -> {:error, msg}
      end)

    case videos do
      {:ok, all_videos} ->
        render(conn, :index, videos: all_videos)

      {:error, message} ->
        render(conn, :index, error: message)
    end

    render(conn, :index, layout: false)
  end
end
