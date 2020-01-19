defmodule Discuss.Conversation do
  alias Discuss.Repo
  alias Discuss.Conversation.Room

  def list_rooms do
    Repo.all(Room)
  end
end