defmodule WillaOsowaWeb.PageController do
  use WillaOsowaWeb, :controller

  def index(conn, _params) do
    conn
    |> put_resp_content_type("text/html")
    |> put_resp_header("cache-control", "no-cache")
    |> send_file(200, index_path())
  end

  # Resolved at runtime so it points at the release's priv dir, not the
  # compile-time build path.
  defp index_path do
    Path.join(:code.priv_dir(:willa_osowa), "static/index.html")
  end
end
