defmodule GsmlgWeb.DashboardController do
  use GsmlgWeb, :controller

  alias Gsmlg.SystemStats
  alias Gsmlg.SystemStats.Process

  action_fallback GsmlgWeb.FallbackController

  def index(conn, _params) do
    processes = SystemStats.list_processes()
    load_avg = SystemStats.load_avg()
    boot_time = SystemStats.boot_time()
    render(conn, "index.json", processes: processes, load_avg: load_avg, boot_time: boot_time)
  end


end
