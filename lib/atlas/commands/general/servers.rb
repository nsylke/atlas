module Atlas::Commands
    module Servers
        extend Discordrb::Commands::CommandContainer

        command(:servers) do |event|
            return if event.author.bot_account?

            event.respond("Atlas is currently on #{'server'.pluralize(event.bot.servers.length)}!")
        end
    end
end