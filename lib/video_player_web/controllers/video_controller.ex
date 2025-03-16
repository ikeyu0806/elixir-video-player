defmodule VideoPlayerWeb.VideoController do
  use VideoPlayerWeb, :controller

  def index(conn, _params) do
    channel_ids = [
      "UCL6JY2DXJNDOIqCP1CRADng",
      "UCaak9sggUeIBPOd8iK_BXcQ"
    ]
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
