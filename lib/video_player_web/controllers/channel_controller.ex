defmodule VideoPlayerWeb.ChannelController do
  use VideoPlayerWeb, :controller
  alias VideoPlayer.Youtube
  alias VideoPlayerWeb.Router.Helpers, as: Routes
  alias VideoPlayer.Repo
  alias VideoPlayer.Youtube.Channel

  def index(conn, _params) do
    channels = Repo.all(Channel)
    render(conn, :index, channels: channels)
  end

  def new(conn, _params) do
    render(conn, :new, layout: false)
  end

  def create(conn, %{"channel_id" => channel_id}) do
    case Youtube.create_channel(%{"channel_id" => channel_id}) do
      {:ok, _channel} ->
        conn
        |> put_flash(:info, "チャンネル登録しました")
        |> redirect(to: "/")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end
end
