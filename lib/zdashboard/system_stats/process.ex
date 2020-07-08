defmodule Zdashboard.SystemStats.Process do
  use Ecto.Schema
  import Ecto.Changeset

  def current do
    System.put_env("LANG", "en_US.UTF-8")
    {out, _code} = System.cmd("ps", ["aux"])
    # if code != 0, do: System.exit(code)
    [_head | list] = out |> String.trim |> String.split("\n")
    processes = list |> Enum.map(fn(proc) ->
      case proc |> String.split do
        [user, pid, cpu, mem, vsz, rss, tt, stat, started, time | command] ->
          %{id: String.to_integer(pid),user: user, pid: pid, cpu: cpu, mem: mem, vsz: vsz, rss: rss, tt: tt, stat: stat, started: started, time: time, command: command}
        :error -> nil
      end
    end)
    processes
  end

  schema "processes" do
    field :command, :string
    field :cpu, :string
    field :mem, :string
    field :pid, :string
    field :rss, :string
    field :started, :string
    field :stat, :string
    field :time, :string
    field :tt, :string
    field :user, :string
    field :vsz, :string

  end

  @doc false
  def changeset(process, attrs) do
    process
    |> cast(attrs, [:user, :pid, :cpu, :mem, :vsz, :rss, :tt, :stat, :started, :time, :command])
    |> validate_required([:user, :pid, :cpu, :mem, :vsz, :rss, :tt, :stat, :started, :time, :command])
  end
end
