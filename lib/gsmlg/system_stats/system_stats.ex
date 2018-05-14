defmodule Gsmlg.SystemStats do
  @moduledoc """
  The SystemStats context.
  """

  import Ecto.Query, warn: false
  alias Gsmlg.Repo

  alias Gsmlg.SystemStats.Process

  def ostype do
    {out1, code1} = System.cmd("sysctl", ["-n", "kernel.ostype"])
    {out2, code2} = System.cmd("sysctl", ["-n", "kern.ostype"])
    case 0 do
      ^code1 = _ -> out1
      ^code2 = _ -> out2
    end |> String.trim
  end

  def list_processes do
    Process.current
  end

  def load_avg do
    {out1, code1} = System.cmd("sysctl", ["-n", "vm.loadavg"])
    {out2, code2} = System.cmd("cat", ["/proc/loadavg"])
    case 0 do
      ^code1 = _ -> out1 |> String.replace("{ ", "") |> String.replace(" }\n", "") |> String.split
      ^code2 = _ -> out2 |> String.split
    end
  end

  def boot_time do
    {out1, code1} = System.cmd("sysctl", ["-n", "kern.boottime"])
    {out2, code2} = System.cmd("cat", ["/proc/uptime"])
    case 0 do
      ^code1 = _ ->
        [ _, _, _, sec, _, _, _, usec | _] = String.split(out1, [" ", ","])
        String.to_integer(sec) + (String.to_integer(usec) / 1000000)
      ^code2 = _ ->
        now = DateTime.utc_now |> DateTime.to_unix
        [running_time | _ ] = String.split(out2)
        now - running_time
    end
  end

end
