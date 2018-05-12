defmodule Gsmlg.Repo.Migrations.CreateProcesses do
  use Ecto.Migration

  def change do
    create table(:processes) do
      add :user, :string
      add :pid, :string
      add :cpu, :string
      add :mem, :string
      add :vsz, :string
      add :rss, :string
      add :tt, :string
      add :stat, :string
      add :started, :string
      add :time, :string
      add :command, :string

      timestamps()
    end

  end
end
