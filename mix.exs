defmodule Entity.MixProject do
  use Mix.Project

  def project do
    [
      app: :entity,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),

      # Hex
      package: package(),
      docs: docs(),
      source_url: "https://github.com/kamaroly/ecto_entity",
      description: "An Elixir Ecto Package to Boost Your Productivity and Achieve 90% throughput in Just 10% of the Time."
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Entity.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:myxql, ">= 0.0.0"},
      {:faker, "~> 0.2.0", hex: :elixir_faker, runtime: Mix.env() == :test},
      {:ex_doc, "~> 0.29.4", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [
      test: ["ecto.drop --quiet", "ecto.create --quiet", "ecto.migrate --quiet", "test"],
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"]
    ]
  end

   defp package() do
    [
      name: "entity",
      # These are the default files included in the package
      files: ~w(lib mix.exs doc README* test),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/kamaroly/ecto_entity"}
    ]
  end
end
