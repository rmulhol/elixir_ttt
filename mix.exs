defmodule ElixirTtt.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_ttt,
     version: "0.0.1",
     elixir: "~> 1.1",
     escript: [main_module: ElixirTtt],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    []
  end
end
