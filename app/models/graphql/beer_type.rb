BeerType = GraphQL::ObjectType.define do
	name 'BeerType'
	description 'A Beer listing from BreweryDB'

	field :name, !types.String, hash_key: "name"
	field :description, types.String, hash_key: "description"
	field :abv, types.String, hash_key: "abv"
	field :serving_glass, types.String do
		resolve ->(obj, args, ctx) { obj['glass'].blank? ? '' : obj['glass']['name'] }
	end
	field :style, types.String do
		resolve ->(obj, args, ctx) { obj['style'].blank? ? '' : obj['style']['name'] }
	end
	field :style_description, types.String do
		resolve ->(obj, args, ctx) { obj['style']['description'] }
	end
	field :availability, types.String do
		resolve ->(obj, args, ctx) { obj['available'].blank? ? '' : obj['available']['name']}
	end
	field :label, types.String do
		resolve ->(obj, args, ctx) { obj['labels'].blank? ? '' : obj['labels']['medium'] }
	end
end
