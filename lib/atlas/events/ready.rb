module Atlas::Events
    module Ready
        extend Discordrb::EventContainer

        ready do |event|
        	event.bot.online
        	event.bot.game = "#{Atlas::CONFIG.prefix}help | #{'Server'.pluralize(event.bot.servers.length)}"

        	Atlas::LOGGER.info("[READY] Logged in as #{event.bot.profile.distinct} (#{event.bot.profile.id}).")
		    Atlas::LOGGER.info("[READY] Connected to #{event.bot.servers.length} servers.")
		    Atlas::LOGGER.info("[READY] OAuth URL: #{event.bot.invite_url}")
        end
    end
end