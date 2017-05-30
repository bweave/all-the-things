require 'wombat'

module Resolvers
	class ClassicCamaros
		def call(_,_,_)
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
		end
	end
end