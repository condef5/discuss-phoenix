defmodule Discuss.Auth do
  alias Discuss.Repo
  alias Discuss.Auth.User

  def register(params) do
    User.registration_changeset(%User{}, params) |> Repo.insert()
  end

  def sign_in(email, password) do
    user = Repo.get_by(User, email: email)

    cond do
      user && user.encrypted_password == password ->
        {:ok, user}
      true ->
        {:error, :unauthorized}
    end
  end

  def sign_out(conn) do
    Plug.Conn.configure_session(conn, drop: true)
  end
end
