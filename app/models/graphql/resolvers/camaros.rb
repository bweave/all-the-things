module Resolvers
	class Camaros
		def call(obj, args, ctx)
			auto_trader = AutoTraderCamaros.new.fetch
			old_car_online = OldCarOnlineCamaros.new.fetch

			auto_trader["camaros"] + old_car_online["camaros"]
		end
	end
end