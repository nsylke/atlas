module Atlas::Commands
    module DuckDuckGo
        extend Discordrb::Commands::CommandContainer

        # This isn't the completed integration and this will change
        # in the near-future once I have the time to do more research
        # and figure out how I want to do the integration.
        command([:duckduckgo, :ddg]) do |event, *args|
            return if event.author.bot_account?

            if args.length > 0
                args = args.join(' ')
                event.respond("<http://duckduckgo.com/#{args.gsub(/\s/, "%20")}?ia=web>")
            else
                event.respond('Please specify an argument.')
            end
        end
    end
end