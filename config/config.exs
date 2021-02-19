use Mix.Config

config :slime, :keep_lines, true
config :yamerl, node_mods: []

config :datocms_graphql_client, :config,
  api_key: System.get_env("DATOCMS_API_KEY"),
  backend: DatoCMS.GraphQLClient.Backends.MemoizingClient

environment_config = "#{Mix.env()}.exs"

if File.regular?(Path.join("config", environment_config)) do
  import_config environment_config
end
