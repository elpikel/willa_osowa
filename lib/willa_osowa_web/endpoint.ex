defmodule WillaOsowaWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :willa_osowa

  # Serve the landing page and its assets straight from priv/static.
  plug Plug.Static,
    at: "/",
    from: :willa_osowa,
    gzip: true,
    only: ~w(assets js index.html robots.txt sitemap.xml favicon.ico)

  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  plug WillaOsowaWeb.Router
end
