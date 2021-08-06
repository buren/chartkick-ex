defmodule Chartkick.Mixfile do
  use Mix.Project

  def project do
    [
      app: :chartkick,
      version: "0.4.0",
      elixir: "~> 1.0",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: package(),
      description: description(),
      licenses: "MIT",
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [extra_applications: [:logger, :eex]]
  end

  defp description do
    """
    Create beautiful JavaScript charts with one line of Elixir
    """
  end

  defp package do
    [
      licenses: ["MIT"],
      maintainers: ["Jacob Burenstam"],
      links: %{
        "GitHub" => "https://github.com/buren/chartkick-ex"
      }
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:elixir_uuid, "~> 1.2"}, {:poison, "~> 5.0", only: :test}]
  end
end
