defmodule VideoPlayerWeb.VideoController do
  use VideoPlayerWeb, :controller

  def index(conn, _params) do
    channel_id = "UCL6JY2DXJNDOIqCP1CRADng"  # チャンネルIDを設定
    case VideoPlayer.Youtube.get_channel_videos(channel_id) do
      {:ok, videos} ->
        render(conn, "index.html", videos: videos)

      {:error, message} ->
        render(conn, "index.html", error: message)
    end

    render(conn, :index, layout: false)
  end
end
