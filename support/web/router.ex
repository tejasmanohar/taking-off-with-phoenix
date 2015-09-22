defmodule Support.Router do
  use Support.Web, :router

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

  scope "/", Support do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/register", RegistrationController, :new
  end

  # Other scopes may use custom stacks.
  # scope "/api", Support do
  #   pipe_through :api
  # end
end
