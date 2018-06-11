module Atlas::Commands
    module Documentation
        extend Discordrb::Commands::CommandContainer

        command([:documentation, :doc, :docs, :syntax]) do |event|
            return if event.author.bot_account?

            event.respond('Documentation is currently unavailable.')
        end
    end
end