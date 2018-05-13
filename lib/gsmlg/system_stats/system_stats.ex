defmodule Gsmlg.SystemStats do
  @moduledoc """
  The SystemStats context.
  """

  import Ecto.Query, warn: false
  alias Gsmlg.Repo

  alias Gsmlg.SystemStats.Process

  @doc """
  Returns the list of processes.

  ## Examples

      iex> list_processes()
      [%Process{}, ...]

  """
  def list_processes do
    Process.current
  end

  def load_avg do
    {out, code} = System.cmd("sysctl", ["-n", "vm.loadavg"])
    out |> String.replace("{ ", "") |> String.replace(" }\n", "") |> String.split
  end

  def boot_time do
    {out, code} = System.cmd("sysctl", ["-n", "kern.boottime"])
    [ _, _, _, sec, _, _, _, usec | _] = String.split(out, [" ", ","])
    String.to_integer(sec) + (String.to_integer(usec) / 1000000)
  end

end
