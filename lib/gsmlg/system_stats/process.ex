defmodule Gsmlg.SystemStats.Process do
  def all do
    System.put_env("LANG", "en_US.UTF-8")
    {out, code} = System.cmd("ps", ["aux"])
    if code != 0, do: System.exit(code)
    [head | list] = out |> String.trim |> String.split("\n")
    processes = list |> Enum.map(fn(proc) ->
      case proc |> String.split do
        [user, pid, cpu, mem, vsz, rss, tt, stat, started, time | command] ->
          [user: user, pid: pid, cpu: cpu, mem: mem, vsz: vsz, rss: rss, tt: tt, stat: stat, started: started, time: time, command: command]
        :error -> nil
      end
    end)
  end
end
