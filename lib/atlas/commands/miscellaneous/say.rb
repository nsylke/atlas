module Atlas::Commands
    module Say
        extend Discordrb::Commands::CommandContainer
        
        command([:say, :echo]) do |event, *args|
            return if event.author.bot_account?

            args = args.join(' ').split(' ', 2)

            case args[0]
            when '-embed'
                if args[1].match(/@everyone/i)
                    event.message.delete
                    event.respond("You are not allowed to use the everyone or here role in this command.")
                elsif args[1].match(/@here/i)
                    event.message.delete
                    event.respond("You are not allowed to use the everyone or here role in this command.")
                else
                    event.channel.send_embed do |embed|
                        embed.description = args[1].to_s
                    end
                end
            else
                args = args.join(' ')

                if args.match(/@everyone/i)
                    event.message.delete
                    event.respond("You are not allowed to use the everyone or here role in this command.")
                elsif args.match(/@here/i)
                    event.message.delete
                    event.respond("You are not allowed to use the everyone or here role in this command.")
                else
                    event.respond(args.to_s)
                end
            end
        end
    end
end