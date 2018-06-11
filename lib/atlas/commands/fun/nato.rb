module Atlas::Commands
    module Nato
        extend Discordrb::Commands::CommandContainer

        command(:nato) do |event, *args|
            args = args.join(' ')

            event.respond(args.to_s.to_nato)
        end
    end
end