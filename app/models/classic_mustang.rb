ClassicMustang = GraphQL::ObjectType.define do
	name 'ClassicMustang'
	description 'A Classic Mustang listing from classics.autotrader.com'

	field :link, !types.String, hash_key: "link"
	field :thumbnail, !types.String, hash_key: "thumbnail"
	field :title, !types.String, hash_key: "title"
	field :price, !types.String, hash_key: "price"
	field :description, !types.String, hash_key: "description"
	field :specs, !types.String.to_list_type, hash_key: "specs"
end
