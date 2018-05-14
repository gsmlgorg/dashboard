defmodule Gsmlg.WebBuild do
  @moduledoc """
  The WebBuild context.
  """
  @filename "package.file"

  def add_build(build) do
    path = Path.join([__DIR__, "..", "..", "..", "priv", "web_build", build.hash])
    File.mkdir_p!(path)
    File.copy(build.assets.path, Path.join(path, @filename))
    File.mkdir_p!(Path.join(path, "branch="<>build.branch))
    File.mkdir_p!(Path.join(path, "commit="<>build.commit))
    File.mkdir_p!(Path.join(path, "filename=" <> build.assets.filename))
    File.mkdir_p!(Path.join(path, "user="<>build.user))
    build
  end

  def get_build(hash) do
    path = Path.join([__DIR__, "..", "..", "..", "priv", "web_build", hash])
    if File.exists?(path) do
      files = File.ls!(path) |> Enum.reduce(%{}, fn(n, acc) ->
        case n do
          "branch=" <> branch -> Map.put(acc, :branch, branch)
          "commit=" <> commit -> Map.put(acc, :commit, commit)
          "filename=" <> filename -> Map.put(acc, :filename, filename)
          "user=" <> user -> Map.put(acc, :user, user)
          @filename -> Map.put(acc, :filepath, Path.join(path, @filename))
        end
      end)
    else
      nil
    end
  end

  def list_build do
    path = Path.join([__DIR__, "..", "..", "..", "priv", "web_build"])
    File.ls!(path) |> Enum.map(&get_build/1)
  end

end
