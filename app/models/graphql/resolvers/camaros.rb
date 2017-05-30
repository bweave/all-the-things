module Resolvers
	class Camaros
		def call(obj, args, ctx)
			auto_trader_results = AutoTraderCamaros.new.fetch
			old_car_online_results = OldCarOnlineCamaros.new.fetch

			auto_trader_results["camaros"] + old_car_online_results["camaros"]
		end
	end
end