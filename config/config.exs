import Config

config :willa_osowa,
  # where lead notifications are delivered
  lead_recipient: "macrac@gmail.com",
  lead_recipient_name: "Willowa Osowa",
  # default "From" for outgoing mail; override via MAIL_FROM in prod. The
  # address must be a verified sender/domain on Brevo.
  mail_from: {"Willowa Osowa", "noreply@przetargowi.pl"}

# Mailer. Prod switches this to Swoosh.Adapters.Brevo in runtime.exs.
config :willa_osowa, WillaOsowa.Mailer, adapter: Swoosh.Adapters.Local

config :willa_osowa, WillaOsowaWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: WillaOsowaWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: WillaOsowa.PubSub

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
