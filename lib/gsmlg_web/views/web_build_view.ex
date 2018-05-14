defmodule GsmlgWeb.WebBuildView do
  use GsmlgWeb, :view
  alias GsmlgWeb.WebBuildView

  def render("index.json", %{web_builds: web_builds}) do
    %{builds: render_many(web_builds, WebBuildView, "web_build.json")}
  end

  def render("show.json", %{web_build: web_build}) do
    %{build: render_one(web_build, WebBuildView, "web_build.json")}
  end

  def render("web_build.json", %{web_build: web_build}) do
    %{id: web_build.id,
      command: web_build.command}
  end
end
