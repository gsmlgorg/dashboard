defmodule ZdashboardWeb.ProcessControllerTest do
  use ZdashboardWeb.ConnCase

  alias Zdashboard.SystemStats
  alias Zdashboard.SystemStats.Process

  @create_attrs %{command: "some command", cpu: "some cpu", mem: "some mem", pid: "some pid", rss: "some rss", started: "some started", stat: "some stat", time: "some time", tt: "some tt", user: "some user", vsz: "some vsz"}
  @update_attrs %{command: "some updated command", cpu: "some updated cpu", mem: "some updated mem", pid: "some updated pid", rss: "some updated rss", started: "some updated started", stat: "some updated stat", time: "some updated time", tt: "some updated tt", user: "some updated user", vsz: "some updated vsz"}
  @invalid_attrs %{command: nil, cpu: nil, mem: nil, pid: nil, rss: nil, started: nil, stat: nil, time: nil, tt: nil, user: nil, vsz: nil}

  def fixture(:process) do
    {:ok, process} = SystemStats.create_process(@create_attrs)
    process
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all processes", %{conn: conn} do
      conn = get conn, process_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create process" do
    test "renders process when data is valid", %{conn: conn} do
      conn = post conn, process_path(conn, :create), process: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, process_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "command" => "some command",
        "cpu" => "some cpu",
        "mem" => "some mem",
        "pid" => "some pid",
        "rss" => "some rss",
        "started" => "some started",
        "stat" => "some stat",
        "time" => "some time",
        "tt" => "some tt",
        "user" => "some user",
        "vsz" => "some vsz"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, process_path(conn, :create), process: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update process" do
    setup [:create_process]

    test "renders process when data is valid", %{conn: conn, process: %Process{id: id} = process} do
      conn = put conn, process_path(conn, :update, process), process: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, process_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "command" => "some updated command",
        "cpu" => "some updated cpu",
        "mem" => "some updated mem",
        "pid" => "some updated pid",
        "rss" => "some updated rss",
        "started" => "some updated started",
        "stat" => "some updated stat",
        "time" => "some updated time",
        "tt" => "some updated tt",
        "user" => "some updated user",
        "vsz" => "some updated vsz"}
    end

    test "renders errors when data is invalid", %{conn: conn, process: process} do
      conn = put conn, process_path(conn, :update, process), process: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete process" do
    setup [:create_process]

    test "deletes chosen process", %{conn: conn, process: process} do
      conn = delete conn, process_path(conn, :delete, process)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, process_path(conn, :show, process)
      end
    end
  end

  defp create_process(_) do
    process = fixture(:process)
    {:ok, process: process}
  end
end
