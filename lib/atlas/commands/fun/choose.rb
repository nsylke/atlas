module Atlas::Commands
	module Choose
		extend Discordrb::Commands::CommandContainer

		command(:choose) do |event, *args|
			event.respond args.join(' ').split(', ').sample
		end
	end
end