defmodule Pedro.Phoenix.Router do
  use Pedro.Phoenix.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Pedro.Phoenix do
    pipe_through :browser # Use the default browser stack

    get "/", Pedro.PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Phoenix do
  #   pipe_through :api
  # end
end
