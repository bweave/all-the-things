Rails.application.routes.draw do
  post 'graphql', to: 'graphql#query', as: 'graphql_query'
	mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
