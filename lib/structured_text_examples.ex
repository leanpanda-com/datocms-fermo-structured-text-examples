defmodule StructuredTextExamples do
  @moduledoc """
  DatoCMS StructuredText Examples
  """

  use Fermo, %{
    base_url: System.get_env("BASE_URL"),
    exclude: ["templates/*", "layouts/*", "javascripts/*", "stylesheets/*"],
    i18n: [:it],
    sitemap: %{
     default_priority: 0.5,
     default_change_frequency: "weekly"
    }
  }
  import Fermo, only: [page: 4]

  use Helpers

  def config do
    config = initial_config()

    Fermo.DatoCMS.GraphQLClient.configure()

    articles = articles()

    config = page(
      config,
      "/templates/home.html.slim",
      "/index.html",
      %{
        articles: articles
      }
    )

    config = Enum.reduce(
      articles,
      config,
      fn article, config ->
        page(
          config,
          "/templates/article.html.slim",
          "/articles/#{article.slug}/index.html",
          %{
            id: article.id
          }
        )
      end
    )

    config = Enum.reduce(
      items(),
      config,
      fn item, config ->
        page(
          config,
          "/templates/item.html.slim",
          "/items/#{item.slug}/index.html",
          %{
            id: item.id
          }
        )
      end
    )

    {:ok, config}
  end
end
