defmodule ZdashboardWeb.DashboardController do
  use ZdashboardWeb, :controller

  alias Zdashboard.SystemStats
  alias Zdashboard.SystemStats.Process

  action_fallback ZdashboardWeb.FallbackController

  def index(conn, _params) do
    processes = SystemStats.list_processes()
    load_avg = SystemStats.load_avg()
    boot_time = SystemStats.boot_time()
    render(conn, "index.json", processes: processes, load_avg: load_avg, boot_time: boot_time)
  end


end
