defmodule Zdashboard.WebBuild do
  @moduledoc """
  The WebBuild context.
  """
  @filename "package.file"

  def add_build(build) do
    path = Path.join([build_path(), build.hash])
    cond do
      String.length(path) <= String.length(build_path()) -> %{"error" => "hash can not be empty"}
      String.length(path) > String.length(build_path()) ->
        File.rm_rf(path)
        created_at = DateTime.utc_now |> DateTime.to_unix
        File.mkdir_p!(path)
        File.copy(build.assets.path, Path.join(path, @filename))
        File.mkdir_p!(Path.join(path, "branch="<>build.branch))
        File.mkdir_p!(Path.join(path, "commit="<>build.commit))
        File.mkdir_p!(Path.join(path, "filename=" <> build.assets.filename))
        File.mkdir_p!(Path.join(path, "user="<>build.user))
        File.mkdir_p!(Path.join(path, "created_at=#{created_at}"))
        get_build(build.hash)
    end
  end

  def get_build(hash, trigger \\ "", commit \\ "") do
    path = Path.join([build_path(), hash])
    if File.exists?(path) do
      build = File.ls!(path) |> Enum.reduce(%{}, fn(n, acc) ->
        case n do
          "branch=" <> branch -> Map.put(acc, :branch, branch)
          "created_at=" <> created_at -> Map.put(acc, :created_at, String.to_integer(created_at))
          "commit=" <> commit -> Map.put(acc, :commit, commit)
          "filename=" <> filename -> Map.put(acc, :filename, filename)
          "user=" <> user -> Map.put(acc, :user, user)
          @filename -> Map.put(acc, :filepath, Path.join(path, @filename))
        end
      end)
      Map.put(build, :hash, hash)
    else
      case trigger do
        "build" ->
          {:error, :not_exists_and_build}
        _ -> {:error, :not_exists}
      end

    end
  end

  def list_build do
    File.ls!(build_path()) |> Enum.map(&get_build/1)
  end

  defp build_path do
    case Keyword.fetch Application.get_env(:zdashboard, ZdashboardWeb.Endpoint), :load_from_system_env do
      {:ok, true} ->
        System.get_env("WEB_BUILD_PATH")
      _ ->
        Path.join([__DIR__, "..", "..", "..", "priv", "web_build"])
    end
  end
end
