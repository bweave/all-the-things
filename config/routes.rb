Rails.application.routes.draw do
  get 'home/index'

  match 'graphql', to: 'graphql#query', as: 'graphql_query', via: [:get, :post]
	mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"

	root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
