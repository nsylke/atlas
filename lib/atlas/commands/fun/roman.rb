module Atlas::Commands
    module Roman
        extend Discordrb::Commands::CommandContainer

        command([:roman, :romannumerals]) do |event, *args|
            return if event.author.bot_account?

            if args[0].nil?
            	event.respond('No arguments specified.')
            	break
            end

            args = args.join(' ').to_i

            return 'Nothing' if args <= 0

            event.respond(args.to_roman)
        end
    end
end