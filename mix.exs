defmodule StructuredTextExamples.MixProject do
  use Mix.Project

  def project do
    [
      app: :structured_text_examples,
      version: "0.1.0",
      elixir: "~> 1.10",
      compilers: Mix.compilers() ++ [:fermo],
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:datocms_graphql_client, "~> 0.14.0"},
      {:fermo, "~> 0.13.3"},
      {:fermo_datocms_graphql_client, "~> 0.13.4"}
    ]
  end
end
