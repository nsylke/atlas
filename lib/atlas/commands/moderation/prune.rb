module Atlas::Commands
	module Prune
		extend Discordrb::Commands::CommandContainer

		command([:prune, :purge]) do |event, args|
			return if event.author.bot_account?

            return "You don't have permission to use this command." unless event.author.permission? :manage_messages
            return "Atlas doesn't have permission to manage messages." unless event.bot.profile.on(event.server).permission? :manage_messages

            amount = args.to_i.clamp(2, 100)
            event.channel.prune(amount)
            event.respond("Pruned #{amount} messages.")
		end
	end
end