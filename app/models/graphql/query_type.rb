QueryType = GraphQL::ObjectType.define do
	name 'Query'
	description 'the root of all... queries'

	field :post do
		type PostType
		argument :id, !types.ID
		resolve -> (_, args, _) { Post.find(args[:id]) }
	end

	field :posts, types[PostType] do
		resolve -> (_, args, _) { Post.all }
	end

	field :classic_camaros, types[ClassicCamaroType] do
		resolve Resolvers::Camaros.new
	end

	field :classic_mustangs , types[ClassicMustangType] do
		resolve Resolvers::ClassicMustangs.new
	end

	field :search_beers, types[BeerType] do
		argument :q, !types.String
		description "Search for beers on BreweryDB"
		resolve Resolvers::BeerSearchResults.new
	end
end
