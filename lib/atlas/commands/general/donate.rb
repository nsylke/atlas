module Atlas::Commands
    module Donate
        extend Discordrb::Commands::CommandContainer

        command([:donate, :paypal, :patreon, :patron]) do |event|
            return if event.author.bot_account?

            event.respond('Whoa, you found the secret command. We currently are not accepting donations, but thank you for the consideration of donating to Atlas!')
        end
    end
end