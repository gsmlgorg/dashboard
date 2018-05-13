defmodule GsmlgWeb.ProcessController do
  use GsmlgWeb, :controller

  alias Gsmlg.SystemStats
  alias Gsmlg.SystemStats.Process

  action_fallback GsmlgWeb.FallbackController

  def index(conn, _params) do
    processes = SystemStats.list_processes()
    render(conn, "index.json", processes: processes)
  end

end
