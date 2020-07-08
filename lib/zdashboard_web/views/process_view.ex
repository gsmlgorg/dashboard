defmodule ZdashboardWeb.ProcessView do
  use ZdashboardWeb, :view
  alias ZdashboardWeb.ProcessView

  def render("index.json", %{processes: processes}) do
    %{data: render_many(processes, ProcessView, "process.json")}
  end

  def render("show.json", %{process: process}) do
    %{data: render_one(process, ProcessView, "process.json")}
  end

  def render("process.json", %{process: process}) do
    %{id: process.id,
      user: process.user,
      pid: process.pid,
      cpu: process.cpu,
      mem: process.mem,
      vsz: process.vsz,
      rss: process.rss,
      tt: process.tt,
      stat: process.stat,
      started: process.started,
      time: process.time,
      command: process.command}
  end
end
