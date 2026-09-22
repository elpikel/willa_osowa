defmodule WillaOsowa.MixProject do
  use Mix.Project

  def project do
    [
      app: :willa_osowa,
      version: "0.1.0",
      elixir: "~> 1.17",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {WillaOsowa.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:phoenix, "~> 1.7.14"},
      {:bandit, "~> 1.5"},
      {:swoosh, "~> 1.16"},
      {:req, "~> 0.5"},
      {:jason, "~> 1.4"},
      {:dns_cluster, "~> 0.1.1"}
    ]
  end
end
