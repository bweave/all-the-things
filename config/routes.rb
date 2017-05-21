Rails.application.routes.draw do
  match 'graphql', to: 'graphql#query', as: 'graphql_query', via: [:get, :post]
	mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
