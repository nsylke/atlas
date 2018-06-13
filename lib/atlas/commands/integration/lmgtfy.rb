module Atlas::Commands
    module Lmgtfy
        extend Discordrb::Commands::CommandContainer

        command(:lmgtfy) do |event, *args|
            return if event.author.bot_account?

            if args.length > 0
                args = args.join(' ')
                event.respond("<http://lmgtfy.com?q=#{args.gsub(/\s/, '+')}>")
            else
                event.respond('Please specify an argument.')
            end
        end
    end
end