PostType = GraphQL::ObjectType.define do
	name "Post"
	description "A blog post"

	field :id, !types.ID
	field :title, !types.String
	field :body, !types.String
end
