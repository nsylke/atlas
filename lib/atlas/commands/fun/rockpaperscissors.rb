module Atlas::Commands
    module RockPaperScissors
        extend Discordrb::Commands::CommandContainer

        command([:rockpaperscissors, :rps]) do |event|
            return if event.author.bot_account?

            event.respond(%w(Rock Paper Scissors).sample)
        end
    end
end