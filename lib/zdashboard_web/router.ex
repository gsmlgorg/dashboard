defmodule ZdashboardWeb.Router do
  use ZdashboardWeb, :router

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

  scope "/", ZdashboardWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

  end

  # Other scopes may use custom stacks.
  scope "/api", ZdashboardWeb do
    pipe_through :api

    get "/processes", ProcessController, :index
    get "/dashboard", DashboardController, :index
    get "/web_build", WebBuildController, :index
    post "/web_build/upload", WebBuildController, :upload
    get "/web_build/:hash", WebBuildController, :download
  end

  scope "/", ZdashboardWeb do
    pipe_through :browser # Use the default browser stack
    get "/*not_found", PageController, :not_found
  end
end
