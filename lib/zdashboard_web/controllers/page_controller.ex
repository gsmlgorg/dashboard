defmodule ZdashboardWeb.PageController do
  use ZdashboardWeb, :controller

  def index(conn, _params) do
    conn
    |> put_layout(false)
    |> render("index.html")
  end

  def not_found(conn, _params) do
    conn
    |> put_layout(false)
    |> render("index.html")
  end
end
