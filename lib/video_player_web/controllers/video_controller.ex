defmodule VideoPlayerWeb.VideoController do
  use VideoPlayerWeb, :controller
  alias VideoPlayer.Youtube.Channel
  alias VideoPlayer.Youtube.Video
  alias VideoPlayer.Repo
  import Ecto.Query

  def index(conn, _params) do
    channel_ids = Repo.all(from c in Channel, select: c.channel_id)

    {videos_result, errors} = Enum.reduce(channel_ids, {[], []}, fn channel_id, {acc_videos, acc_errors} ->
      case VideoPlayer.Youtube.get_channel_videos(channel_id) do
        {:ok, videos} -> {acc_videos ++ videos, acc_errors}
        {:error, msg} -> {acc_videos, acc_errors ++ [msg]}
      end
    end)

    render(conn, :index, videos: videos_result, errors: errors)
  end
end
