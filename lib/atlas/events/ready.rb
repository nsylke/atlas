module Atlas::Events
    module Ready
        extend Discordrb::EventContainer

        include Atlas::Loggable

        ready do |event|
        	event.bot.online
        	event.bot.game = "#{Atlas::CONFIG.prefix}help | #{'Server'.pluralize(event.bot.servers.length)}"

        	logger.info "Logged in as #{event.bot.profile.distinct} (#{event.bot.profile.id})."
		    logger.info "Connected to #{"server".pluralize(event.bot.servers.length)}."
		    logger.info "OAuth URL: #{event.bot.invite_url}"
        end
    end
end