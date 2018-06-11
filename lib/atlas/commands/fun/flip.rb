module Atlas::Commands
    module Flip
        extend Discordrb::Commands::CommandContainer

        command(:flip) do |event|
            return if event.author.bot_account?

            event.respond(%w(Heads Tails).sample)
        end
    end
end