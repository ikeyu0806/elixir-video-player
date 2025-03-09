defmodule VideoPlayerWeb.ChannelController do
  use VideoPlayerWeb, :controller

  def new(conn, _params) do
    render(conn, :new, layout: false)
  end

  def create(conn, %{"channel_id" => channel_id}) do
    case Youtube.create_channel(channel_id) do
      {:ok, _channel} ->
        conn
        |> put_flash(:info, "チャンネル登録しました")
        |> redirect(to: Routes.channel_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end
end
