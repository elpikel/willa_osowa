import Config

# Start the web server when the release is booted via `bin/server`, which sets
# PHX_SERVER=true (see rel/overlays/bin/server).
if System.get_env("PHX_SERVER") do
  config :willa_osowa, WillaOsowaWeb.Endpoint, server: true
end

if config_env() == :prod do
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  host = System.get_env("PHX_HOST") || "willowagdansk.pl"
  port = String.to_integer(System.get_env("PORT") || "4000")

  config :willa_osowa, WillaOsowaWeb.Endpoint,
    url: [host: host, port: 443, scheme: "https"],
    http: [
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: port
    ],
    secret_key_base: secret_key_base

  # ## Mailer — Brevo (HTTP API)
  #
  # Lead notifications are sent via Brevo's API. Create a key in Brevo
  # (SMTP & API → API Keys) and set:
  #   BREVO_API_KEY   the Brevo API key
  # The sender (mail_from) is fixed in config/config.exs.
  # (Uses Swoosh.ApiClient.Req, configured in config/prod.exs.)
  config :willa_osowa, WillaOsowa.Mailer,
    adapter: Swoosh.Adapters.Brevo,
    api_key:
      System.get_env("BREVO_API_KEY") ||
        raise("environment variable BREVO_API_KEY is missing")
end
