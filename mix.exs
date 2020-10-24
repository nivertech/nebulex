defmodule Nebulex.Mixfile do
  use Mix.Project

  @version "1.2.2"

  def project do
    [
      app: :nebulex,
      version: @version,
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),

      # Docs
      name: "Nebulex",
      docs: docs(),

      # Testing
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],

      # Dialyzer
      dialyzer: dialyzer(),

      # Hex
      package: package(),
      description: "A fast, flexible and powerful distributed caching framework for Elixir."
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def application do
    []
  end

  defp deps do
    [
      {:shards, git: "git@github.com:nivertech/shards.git", branch: "v0.6.2_disable_warnings_as_errors"},
      {:decorator, "~> 1.3"},

      # Test
      {:excoveralls, "~> 0.13", only: :test},
      {:ex2ms, "~> 1.6", only: :test},
      {:mock, "~> 0.3", only: :test},
      {:benchee, "~> 1.0", optional: true, only: :test},
      {:benchee_html, "~> 1.0", optional: true, only: :test},
      {:dialyxir, "~> 1.0", optional: true, only: [:dev, :test], runtime: false},
      {:credo, "~> 1.4", optional: true, only: [:dev, :test]},

      # Docs
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:inch_ex, "~> 2.0", only: :docs}
    ]
  end

  defp package do
    [
      name: :nebulex,
      maintainers: ["Carlos Bolanos"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/cabol/nebulex"}
    ]
  end

  defp docs do
    [
      main: "Nebulex",
      source_ref: "v#{@version}",
      canonical: "http://hexdocs.pm/nebulex",
      source_url: "https://github.com/cabol/nebulex",
      extras: [
        "guides/getting-started.md",
        "guides/hooks.md",
        "guides/caching-decorators.md"
      ]
    ]
  end

  defp dialyzer do
    [
      plt_add_apps: [:shards, :mix, :eex],
      plt_file: {:no_warn, "priv/plts/dialyzer-#{Mix.env()}.plt"},
      flags: [
        :unmatched_returns,
        :error_handling,
        :race_conditions,
        :no_opaque,
        :unknown,
        :no_return
      ]
    ]
  end
end
