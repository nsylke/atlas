module Atlas::Commands
    module Version
        extend Discordrb::Commands::CommandContainer

        command([:version, :ver]) do |event|
            return if event.author.bot_account?

            event.respond("The current version of Atlas is #{Atlas::VERSION.freeze}.")
        end
    end
end