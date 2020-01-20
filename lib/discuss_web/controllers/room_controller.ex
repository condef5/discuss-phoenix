defmodule DiscussWeb.RoomController do
  use DiscussWeb, :controller
  alias Discuss.Conversation
  alias Discuss.Conversation.Room

  def index(conn, _params) do
    rooms = Conversation.list_rooms()
    render conn, "index.html", rooms: rooms
  end

  def new(conn, _params) do
    changeset = Conversation.change_room(%Room{})
    render conn, "new.html", changeset: changeset
  end

  def show(conn, %{"id" => id}) do
    room = Conversation.get_room!(id)
    render conn, "show.html", room: room
  end

  def create(conn, %{"room" => room_params}) do
    case Conversation.create_room(room_params) do
      {:ok, _room} ->
        conn
        |> put_flash(:info, "Room created successfully.")
        |> redirect(to: Routes.room_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

end
