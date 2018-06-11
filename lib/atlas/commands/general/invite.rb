module Atlas::Commands
    module Invite
        extend Discordrb::Commands::CommandContainer

        command([:invite, :inv]) do |event|
            return if event.author.bot_account?

            event.author.pm("OAuth: https://discordapp.com/oauth2/authorize?&client_id=212744072073314304&scope=bot&permissions=268443670")
            event.respond('We have sent you an OAuth invite for Atlas in private message.')
        end
    end
end