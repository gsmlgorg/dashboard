defmodule ZdashboardWeb.PageView do
  use ZdashboardWeb, :view

  def render("index.html", _assigns) do
    index_html = Path.join([__DIR__, "..", "..", "..", "priv", "static", "index.html"])
    if Application.get_env(:zdashboard, :environment) == :prod do
      index_html = Path.join([Application.app_dir(:zdashboard), "priv", "static", "index.html"])
    end
    html = File.read!(index_html)
    {:safe, html}
  end
end
