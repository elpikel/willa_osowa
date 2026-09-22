defmodule WillaOsowa.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {DNSCluster, query: Application.get_env(:willa_osowa, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: WillaOsowa.PubSub},
      WillaOsowaWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: WillaOsowa.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    WillaOsowaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
