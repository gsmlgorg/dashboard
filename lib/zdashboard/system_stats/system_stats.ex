defmodule Zdashboard.SystemStats do
  @moduledoc """
  The SystemStats context.
  """

  alias Zdashboard.SystemStats.Process

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
    case ostype() do
      "Darwin" ->
        {out, _code} = System.cmd("sysctl", ["-n", "vm.loadavg"])
        out |> String.replace("{ ", "") |> String.replace(" }\n", "") |> String.split
      "Linux" ->
        {out, _code} = System.cmd("cat", ["/proc/loadavg"])
        out |> String.split |> Enum.take(3)
    end
  end

  def boot_time do
    case ostype() do
      "Darwin" ->
        {out, _code} = System.cmd("sysctl", ["-n", "kern.boottime"])
        [ _, _, _, sec, _, _, _, usec | _] = String.split(out, [" ", ","])
        String.to_integer(sec) + (String.to_integer(usec) / 1000000)
      "Linux" ->
        {out, _code} = System.cmd("cat", ["/proc/uptime"])
        now = DateTime.utc_now |> DateTime.to_unix
        [running_time | _ ] = String.split(out)
        now - String.to_float(running_time)
    end
  end

end
