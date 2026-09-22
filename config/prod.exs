import Config

config :willa_osowa, WillaOsowaWeb.Endpoint, cache_static_manifest: nil

# Send transactional email through Brevo's HTTP API via Req.
config :swoosh, api_client: Swoosh.ApiClient.Req
config :swoosh, local: false

config :logger, level: :info

# Runtime configuration (secrets, host, Brevo key) lives in runtime.exs.
