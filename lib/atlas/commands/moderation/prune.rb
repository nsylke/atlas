module Atlas::Commands
	module Prune
		extend Discordrb::Commands::CommandContainer

		command(:prune) do |event, args|
			return if event.author.bot_account?

            unless event.author.permission? :manage_messages
                event.respond("You don't have permission to use this command.")
                break
            end

            unless Atlas::BOT.member(event.server, Atlas::BOT.profile.id).permission? :manage_messages
                event.respond("Atlas doesn't have permission to manage messages.")
                break
            end

            amount = args.to_i.clamp(2, 100)
            event.channel.prune(amount)
            event.respond("Pruned #{amount} messages.")
		end
	end
end