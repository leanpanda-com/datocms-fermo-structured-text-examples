defmodule Helpers do
  defmacro __using__(_opts \\ %{}) do
    quote do
      import DatoCMS.GraphQLClient.MetaTagHelpers
      import FermoHelpers.Links
      import Fermo.DatoCMS.GraphQLClient, only: [query!: 1, query!: 2]

      def articles do
        result = query!(
          """
          {
            allArticles {
              id
              slug
              title
            }
          }
          """
        )

        result[:allArticles]
        |> Enum.sort(&(&1[:title] <= &2[:title]))
      end

      def items do
        result = query!(
          """
          {
            allItems {
              id
              slug
              title
            }
          }
          """
        )

        result[:allItems]
        |> Enum.sort(&(&1[:title] <= &2[:title]))
      end

      def render_link_to_record(%{__typename: "ArticleRecord"} = article, node) do
        [~s(<a href="/articles/#{article.slug}">#{hd(node.children).value}</a>)]
      end
      def render_link_to_record(%{__typename: "ItemRecord"} = item, node) do
        [~s(<a href="/items/#{item.slug}">#{hd(node.children).value}</a>)]
      end

      def render_inline_record(%{__typename: "ArticleRecord"} = article) do
        ["<strong>#{article.title}</strong>"]
      end
      def render_inline_record(%{__typename: "ItemRecord"} = item) do
        ["<strong>\"#{item.title}\"</strong>"]
      end

      def render_block(%{__typename: "MyarticleblockRecord"} = block) do
        [~s(<div><h1>#{block.articleBlockTitle}</h1><p><img src="#{block.image.url}"></p></div>)]
      end

      def structured_text_to_html(dast) do
        options = %{
          renderers: %{
            render_link_to_record: &render_link_to_record/2,
            render_inline_record: &render_inline_record/1,
            render_block: &render_block/1
          }
        }
        DatoCMS.StructuredText.to_html(dast, options)
      end
    end
  end
end
