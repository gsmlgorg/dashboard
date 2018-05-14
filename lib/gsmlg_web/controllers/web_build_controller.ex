defmodule GsmlgWeb.WebBuildController do
  use GsmlgWeb, :controller

  action_fallback GsmlgWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.json", web_builds: [])
  end

  def upload(conn, %{} = params) do
  end

end
