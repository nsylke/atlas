module Atlas::Commands
    module Home
        extend Discordrb::Commands::CommandContainer

        command([:home, :join, :support]) do |event|
            return if event.author.bot_account?

            event.author.pm('Atlas: https://discord.gg/67taXWN')
            event.respond('We have sent you an invite to Atlas in private message.')
        end
    end
end