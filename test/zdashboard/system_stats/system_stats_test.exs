defmodule Zdashboard.SystemStatsTest do
  use Zdashboard.DataCase

  alias Zdashboard.SystemStats

  describe "processes" do
    alias Zdashboard.SystemStats.Process

    @valid_attrs %{command: "some command", cpu: "some cpu", mem: "some mem", pid: "some pid", rss: "some rss", started: "some started", stat: "some stat", time: "some time", tt: "some tt", user: "some user", vsz: "some vsz"}
    @update_attrs %{command: "some updated command", cpu: "some updated cpu", mem: "some updated mem", pid: "some updated pid", rss: "some updated rss", started: "some updated started", stat: "some updated stat", time: "some updated time", tt: "some updated tt", user: "some updated user", vsz: "some updated vsz"}
    @invalid_attrs %{command: nil, cpu: nil, mem: nil, pid: nil, rss: nil, started: nil, stat: nil, time: nil, tt: nil, user: nil, vsz: nil}

    def process_fixture(attrs \\ %{}) do
      {:ok, process} =
        attrs
        |> Enum.into(@valid_attrs)
        |> SystemStats.create_process()

      process
    end

    test "list_processes/0 returns all processes" do
      process = process_fixture()
      assert SystemStats.list_processes() == [process]
    end

    test "get_process!/1 returns the process with given id" do
      process = process_fixture()
      assert SystemStats.get_process!(process.id) == process
    end

    test "create_process/1 with valid data creates a process" do
      assert {:ok, %Process{} = process} = SystemStats.create_process(@valid_attrs)
      assert process.command == "some command"
      assert process.cpu == "some cpu"
      assert process.mem == "some mem"
      assert process.pid == "some pid"
      assert process.rss == "some rss"
      assert process.started == "some started"
      assert process.stat == "some stat"
      assert process.time == "some time"
      assert process.tt == "some tt"
      assert process.user == "some user"
      assert process.vsz == "some vsz"
    end

    test "create_process/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SystemStats.create_process(@invalid_attrs)
    end

    test "update_process/2 with valid data updates the process" do
      process = process_fixture()
      assert {:ok, process} = SystemStats.update_process(process, @update_attrs)
      assert %Process{} = process
      assert process.command == "some updated command"
      assert process.cpu == "some updated cpu"
      assert process.mem == "some updated mem"
      assert process.pid == "some updated pid"
      assert process.rss == "some updated rss"
      assert process.started == "some updated started"
      assert process.stat == "some updated stat"
      assert process.time == "some updated time"
      assert process.tt == "some updated tt"
      assert process.user == "some updated user"
      assert process.vsz == "some updated vsz"
    end

    test "update_process/2 with invalid data returns error changeset" do
      process = process_fixture()
      assert {:error, %Ecto.Changeset{}} = SystemStats.update_process(process, @invalid_attrs)
      assert process == SystemStats.get_process!(process.id)
    end

    test "delete_process/1 deletes the process" do
      process = process_fixture()
      assert {:ok, %Process{}} = SystemStats.delete_process(process)
      assert_raise Ecto.NoResultsError, fn -> SystemStats.get_process!(process.id) end
    end

    test "change_process/1 returns a process changeset" do
      process = process_fixture()
      assert %Ecto.Changeset{} = SystemStats.change_process(process)
    end
  end
end
