module Resolvers
	class Mustangs 
		def call(obj, args, ctx)
			auto_trader = AutoTraderMustangs.new.fetch
			old_car_online = OldCarOnlineMustangs.new.fetch

			auto_trader["mustangs"] + old_car_online["mustangs"]
		end
	end
end