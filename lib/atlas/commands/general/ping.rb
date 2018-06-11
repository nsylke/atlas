module Atlas::Commands
    module Ping
        extend Discordrb::Commands::CommandContainer

        command(:ping) do |event|
            return if event.author.bot_account?

            "Pong!"
        end

        command(:pong) do |event|
            return if event.author.bot_account?

            "Ping!"
        end
    end
end