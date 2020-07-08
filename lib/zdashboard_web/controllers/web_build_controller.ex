defmodule ZdashboardWeb.WebBuildController do
  use ZdashboardWeb, :controller

  action_fallback ZdashboardWeb.FallbackController

  def index(conn, _params) do
    builds = Zdashboard.WebBuild.list_build
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
  def upload(conn, %{"hash" => ""} = params), do: IO.inspect params
  def upload(conn, %{"branch" => branch,
                     "commit" => commit,
                     "user" => user,
                     "assets" => assets,
                     "hash" => hash} = _params) do
    web_build = %{commit: commit, hash: hash, user: user, branch: branch, assets: assets}
    build = Zdashboard.WebBuild.add_build(web_build)
    render(conn, "show.json", web_build: build)
  end
  def upload(conn, params), do: IO.inspect params

  def download(conn, %{"hash" => hash} = params) do
    trigger = Map.get(params, "trigger", "")
    commit = Map.get(params, "commit", "")
    IO.inspect params
    case Zdashboard.WebBuild.get_build(hash, trigger, commit) do
      {:error, :not_exists_and_build} ->
        conn
          |> put_status(:service_unavailable)
          |> render("not_exists.json", auto_build: true)
      {:error, :not_exists} ->
        conn
          |> put_status(:not_found)
          |> render("not_exists.json", auto_build: false)
      %{:filepath => filepath, :filename => filename} ->
        send_download(conn, {:file, filepath}, filename: filename)
      _ ->
        conn |> render(ZdashboardWeb.ErrorView, :"404")
    end
  end

end
