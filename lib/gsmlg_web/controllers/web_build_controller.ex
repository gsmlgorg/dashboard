defmodule GsmlgWeb.WebBuildController do
  use GsmlgWeb, :controller

  action_fallback GsmlgWeb.FallbackController

  def index(conn, _params) do
    builds = Gsmlg.WebBuild.list_build
    render(conn, "index.json", web_builds: builds)
  end

  @doc """
  upload params example
  %{
    "assets" => %Plug.Upload{
      content_type: "application/octet-stream",
      filename: "assets.tar.bz2",
      path: "/var/folders/s0/hl1d3jkx5jx3gs69033nc6d80000gn/T//plug-1526/multipart-1526309005-979562536723404-1"
    },
    "branch" => "zddi-3.10",
    "commit" => "272efb80d0cf87e85efde0c365cbfe022eaf3923",
    "user" => "gsmlg"
  }
  """
  def upload(conn, %{"branch" => branch,
                     "commit" => commit,
                     "user" => user,
                     "assets" => assets,
                     "hash" => hash} = params) do
    web_build = %{commit: commit, hash: hash, user: user, branch: branch, assets: assets}
    build = Gsmlg.WebBuild.add_build(web_build)
    render(conn, "show.json", web_build: build)
  end
  def upload(conn, params), do: IO.inspect params

  def download(conn, %{"hash" => hash}) do
    build = Gsmlg.WebBuild.get_build(hash)
    send_download(conn, {:file, build.filepath}, filename: build.filename)
  end

end
