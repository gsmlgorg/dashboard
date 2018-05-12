defmodule GsmlgWeb.ProcessController do
  use GsmlgWeb, :controller

  alias Gsmlg.SystemStats
  alias Gsmlg.SystemStats.Process

  action_fallback GsmlgWeb.FallbackController

  def index(conn, _params) do
    processes = SystemStats.list_processes()
    render(conn, "index.json", processes: Process.current)
  end

  def create(conn, %{"process" => process_params}) do
    with {:ok, %Process{} = process} <- SystemStats.create_process(process_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", process_path(conn, :show, process))
      |> render("show.json", process: process)
    end
  end

  def show(conn, %{"id" => id}) do
    process = SystemStats.get_process!(id)
    render(conn, "show.json", process: process)
  end

  def update(conn, %{"id" => id, "process" => process_params}) do
    process = SystemStats.get_process!(id)

    with {:ok, %Process{} = process} <- SystemStats.update_process(process, process_params) do
      render(conn, "show.json", process: process)
    end
  end

  def delete(conn, %{"id" => id}) do
    process = SystemStats.get_process!(id)
    with {:ok, %Process{}} <- SystemStats.delete_process(process) do
      send_resp(conn, :no_content, "")
    end
  end
end
