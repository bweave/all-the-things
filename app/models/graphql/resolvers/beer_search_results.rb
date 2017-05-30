require 'net/http'
require 'json'

module Resolvers
	class BeerSearchResults
		def call(_, args, _)
			url = "https://api.brewerydb.com/v2/search/?key=9b129f8401ba238992814be1df430b5d&q=#{args[:q]}&type=beer"
			uri = URI(url)
			resp = Net::HTTP.get(uri)
			json = JSON.parse(resp)
			json["data"]
		end
	end
end