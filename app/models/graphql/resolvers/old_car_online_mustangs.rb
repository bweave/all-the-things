require 'wombat'

module Resolvers
	class OldCarOnlineMustangs
		def fetch
			results = Wombat.crawl do
				base_url "http://www.oldcaronline.com"
				path "/Classic-Ford-Mustang-For-Sale-On-OldCarOnline.com/results?year1=1967&year2=1969&make=Ford&model=Mustang&pricemin=10000&pricemax=25000&ads_per_page=90"

				mustangs "css=div.result-offer", :iterator do
					link xpath: "./a/@href"
					thumbnail xpath: "./a/div/img/@src"
					title css: ".result-content h5"
					price css: ".result-content .price span"
					description "css=.result-link", :follow do
						text "css=.description"
					end
					specs "", :list
				end
			end

			results["mustangs"].map do |mustang|
				mustang["description"] = mustang["description"].first["text"]
				mustang
			end

			results
		end
	end
end