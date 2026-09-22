defmodule WillaOsowaWeb.Router do
  use WillaOsowaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Landing page
  get "/", WillaOsowaWeb.PageController, :index

  # Lead form submissions -> Brevo email
  scope "/api" do
    pipe_through :api

    post "/lead", WillaOsowaWeb.LeadController, :create
  end

  # Analytics event proxy to avoid ad blockers. The tracking script itself is a
  # vendored static file at priv/static/js/script.js (served by Plug.Static).
  post "/api/event", WillaOsowaWeb.AnalyticsController, :event

  # Preview leads captured by the local mailbox in dev.
  if Application.compile_env(:willa_osowa, :dev_routes) do
    scope "/dev" do
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
