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
      {:datocms_graphql_client, git: "https://github.com/leanpanda-com/elixir_datocms_graphql_client", override: true},
      {:fermo, "~> 0.13.3", git: "https://github.com/leanpanda-com/fermo", override: true},
      {:fermo_datocms_graphql_client, "~> 0.13.3", git: "https://github.com/leanpanda-com/fermo_datocms_graphql_client", override: true}
    ]
  end
end
