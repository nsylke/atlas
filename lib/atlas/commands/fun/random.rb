module Atlas::Commands
    module Random
        extend Discordrb::Commands::CommandContainer

        command([:random, :rand]) do |event, min, max|
            return if event.author.bot_account?

            if max 
                max = max.to_i > 2147483647 ? max = 2147483647 : max
                
                event.respond(rand(min.to_i..max.to_i))
            elsif min
                min = min.to_i > 2147483647 ? min = 2147483647 : mi
                n

                event.respond(rand(0..min.to_i))
            else
                event.respond(rand(0..2147483647))
            end
        end
    end
end