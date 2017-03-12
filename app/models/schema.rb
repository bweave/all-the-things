require 'net/http'
require 'json'
require 'wombat'

PostType = GraphQL::ObjectType.define do
	name "Post"
	description "A blog post"

	field :id, !types.ID
	field :title, !types.String
	field :body, !types.String
end

ClassicMustangType = GraphQL::ObjectType.define do
	name 'ClassicMustang'
	description 'A Classic Mustang listing from classics.autotrader.com'

	field :link, !types.String, hash_key: "link"
	field :thumbnail, !types.String, hash_key: "thumbnail"
	field :title, !types.String, hash_key: "title"
	field :price, !types.String, hash_key: "price"
	field :description, !types.String, hash_key: "description"
	field :specs, !types.String.to_list_type, hash_key: "specs"
end

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

QueryType = GraphQL::ObjectType.define do
	name 'Query'
	description 'the root of all... queries'

	field :post do
		type PostType
		argument :id, !types.ID
		resolve -> (obj, args, ctx) {
			Post.find(args[:id])
		}
	end

	field :posts, types[PostType] do
		resolve -> (obj, args, ctx) {
			Post.all
		}
	end

	field :classic_mustangs , types[ClassicMustangType] do
		resolve -> (obj, args, ctx) {
			results = Wombat.crawl do
				base_url "https://classics.autotrader.com"
				path "/classic-cars-for-sale/ford-mustang-for-sale?year_from=1964&year_to=1969"

				mustangs "css=div.listing", :iterator do
					link "css=.details", :html do |markup|
						/href\s*=\s*"([^"]*)"/.match(markup)[1]
					end
					thumbnail "css=.thumbnail a", :html do |markup|
						/src\s*=\s*"([^"]*)"/.match(markup)[1]
					end
					title css: "h3.model"
					price css: "h4.price"
					specs "css=ul.specs li", :list
					description css: ".description"
				end
			end

			results["mustangs"]
		}
	end

	field :search_beers, types[BeerType] do
		argument :q, !types.String
		description "Search for beers on BreweryDB"
		resolve ->(obj, args, ctx) {
			url = "https://api.brewerydb.com/v2/search/?key=9b129f8401ba238992814be1df430b5d&q=#{args[:q]}&type=beer"
			uri = URI(url)
			resp = Net::HTTP.get(uri)
			json = JSON.parse(resp)
			json["data"]
		}
	end
end

Schema = GraphQL::Schema.define do
	query QueryType
end
