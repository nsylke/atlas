module Atlas::Commands
    module Nato
        extend Discordrb::Commands::CommandContainer

        command(:nato) do |event, *args|
        	return if event.author.bot_account?
        	
        	if args[0].nil?
            	event.respond('No arguments specified.')
            	break
            end

            args = args.join(' ')

            event.respond(args.to_s.to_nato)
        end
    end
end