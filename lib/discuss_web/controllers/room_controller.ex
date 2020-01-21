defmodule DiscussWeb.RoomController do
  use DiscussWeb, :controller
  alias Discuss.Conversation
  alias Discuss.Conversation.Room

  plug DiscussWeb.Plugs.AuthenticateUser when action not in [:index]

  def index(conn, _params) do
    rooms = Conversation.list_rooms()
    render conn, "index.html", rooms: rooms
  end

  def new(conn, _params) do
    changeset = Conversation.change_room(%Room{})
    render conn, "new.html", changeset: changeset
  end

  def edit(conn, %{"id" => id}) do
    room = Conversation.get_room!(id)
    changeset = Conversation.change_room(room)
    render conn, "edit.html", changeset: changeset, room: room
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

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = Conversation.get_room!(id)

    case Conversation.update_room(room, room_params) do
      {:ok, room} ->
        conn
        |> put_flash(:info, "Room updated successfully.")
        |> redirect(to: Routes.room_path(conn, :show, room))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", room: room, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    room = Conversation.get_room!(id)
    {:ok, _room} = Conversation.delete_room(room)

    conn
    |> put_flash(:info, "Room deleted successfully.")
    |> redirect(to: Routes.room_path(conn, :index))
  end

end
