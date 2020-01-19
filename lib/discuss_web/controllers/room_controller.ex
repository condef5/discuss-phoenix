defmodule DiscussWeb.RoomController do
  use DiscussWeb, :controller

  def index(conn, _params) do
    rooms = Discuss.Conversation.list_rooms()
    render conn, "index.html", rooms: rooms
  end

end