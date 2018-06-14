module Atlas::Commands
    module Emojify
        extend Discordrb::Commands::CommandContainer

        command(:emojify) do |event, *args|
        	return if event.author.bot_account?
        	
        	if args[0].nil?
            	event.respond('No arguments specified.')
            	break
            end

            args = args.join(' ')

            event.respond(args.to_s.to_emojis)
        end
    end
end