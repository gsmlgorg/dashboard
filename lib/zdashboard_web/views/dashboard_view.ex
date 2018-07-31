defmodule ZdashboardWeb.DashboardView do
  use ZdashboardWeb, :view
  alias ZdashboardWeb.DashboardView

  def render("index.json", %{processes: processes, load_avg: load_avg, boot_time: boot_time}) do
    %{processes: render_many(processes, DashboardView, "process.json"),
      time: DateTime.utc_now |> DateTime.to_unix,
      boot_time: boot_time,
      load_avg: load_avg}
  end

  def render("show.json", %{process: process}) do
    %{data: render_one(process, DashboardView, "process.json")}
  end

  def render("process.json", %{dashboard: dashboard}) do
    %{id: dashboard.id,
      user: dashboard.user,
      pid: dashboard.pid,
      cpu: dashboard.cpu,
      mem: dashboard.mem,
      vsz: dashboard.vsz,
      rss: dashboard.rss,
      tt: dashboard.tt,
      stat: dashboard.stat,
      started: dashboard.started,
      time: dashboard.time,
      command: dashboard.command}
  end
end
