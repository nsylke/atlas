module Atlas::Commands
	module Choose
		extend Discordrb::Commands::CommandContainer

		command(:choose) do |event, *args|
			if args[0].nil?
            	event.respond('No arguments specified.')
            	break
            end

			event.respond args.join(' ').split(', ').sample
		end
	end
end