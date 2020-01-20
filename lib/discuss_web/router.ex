defmodule DiscussWeb.Router do
  use DiscussWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DiscussWeb do
    pipe_through :browser
    get "/", RoomController, :index
    get "/rooms/new", RoomController, :new
    get "/rooms/:id/edit", RoomController, :edit
    get "/rooms/:id", RoomController, :show
    post "/rooms", RoomController, :create
    put "/rooms", RoomController, :update
    delete "/rooms/:id", RoomController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", DiscussWeb do
  #   pipe_through :api
  # end
end
