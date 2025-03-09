defmodule VideoPlayerWeb.ChannelController do
  use VideoPlayerWeb, :controller

  def new(conn, _params) do
    render(conn, :new, layout: false)
  end
end
