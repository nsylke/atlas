module Atlas::Commands
    module Random
        extend Discordrb::Commands::CommandContainer

        command([:random, :rand]) do |event, min, max|
            return if event.author.bot_account?

            if max 
                event.respond(rand(min.to_i..max.to_i))
            elsif min
                event.respond(rand(0..min.to_i))
            else
                event.respond(rand(0..2147483647))
            end
        end
    end
end