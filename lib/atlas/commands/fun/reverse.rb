module Atlas::Commands
    module Reverse
        extend Discordrb::Commands::CommandContainer

        command([:reverse, :rev]) do |event, *args|
            return if event.author.bot_account?

            if args[0].nil?
            	event.respond('No arguments specified.')
            	break
            end

            args = args.join(' ')

            event.respond(args.to_s.reverse!)
        end
    end
end