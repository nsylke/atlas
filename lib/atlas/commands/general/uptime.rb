module Atlas::Commands
    module Uptime
        extend Discordrb::Commands::CommandContainer

        command(:uptime) do |event|
            return if event.author.bot_account?

            event.respond("Atlas has currently been up for #{Atlas::UPTIME.uptime}.")
        end
    end
end