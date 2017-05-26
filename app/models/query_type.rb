require 'net/http'
require 'json'
require 'wombat'

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

	field :classic_camaros, types[ClassicCamaro] do
		resolve -> (obj, args, ctx) {
			results = Wombat.crawl do
				base_url "https://classics.autotrader.com"
				path "/classic-cars-for-sale/chevrolet-camaro-for-sale?year_from=1967&year_to=1969&price_from=10000&price_to=25000"

				camaros "css=div.listing", :iterator do
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

			results["camaros"]
		}
	end

	field :classic_mustangs , types[ClassicMustang] do
		resolve -> (obj, args, ctx) {
			results = Wombat.crawl do
				base_url "https://classics.autotrader.com"
				path "/classic-cars-for-sale/ford-mustang-for-sale?year_from=1964&year_to=1969&price_from=10000&price_to=25000"

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

	field :search_beers, types[Beer] do
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
