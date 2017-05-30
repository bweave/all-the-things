require 'wombat'

module Resolvers
	class OldCarOnlineCamaros
		def fetch
			results = Wombat.crawl do
				base_url "http://www.oldcaronline.com"
				path "/Classic-Chevrolet-Camaro-For-Sale-On-OldCarOnline.com/results?year1=1967&year2=1969&make=Chevrolet&model=Camaro&pricemin=10000&pricemax=25000&ads_per_page=90"

				camaros "css=div.result-offer", :iterator do
					link xpath: "./a/@href"
					thumbnail xpath: "./a/div/img/@src"
					title css: ".result-content h5"
					price css: ".result-content .price span"
					description "css=.result-link", :follow do
						text "css=.description"
					end
				end
			end

			results["camaros"].map do |camaro|
				camaro["description"] = camaro["description"].first["text"]
				camaro
			end

			results
		end
	end
end