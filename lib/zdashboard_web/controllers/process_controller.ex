defmodule ZdashboardWeb.ProcessController do
  use ZdashboardWeb, :controller

  alias Zdashboard.SystemStats
  alias Zdashboard.SystemStats.Process

  action_fallback ZdashboardWeb.FallbackController

  def index(conn, _params) do
    processes = SystemStats.list_processes()
    render(conn, "index.json", processes: processes)
  end

end
