defmodule WillaOsowaWeb.PageController do
  use WillaOsowaWeb, :controller

  @index Application.app_dir(:willa_osowa, "priv/static/index.html")

  def index(conn, _params) do
    conn
    |> put_resp_content_type("text/html")
    |> put_resp_header("cache-control", "no-cache")
    |> send_file(200, @index)
  end
end
