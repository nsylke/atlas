module Atlas::Events
    module ServerDelete
        extend Discordrb::EventContainer

        server_delete do |event|
        	event.bot.game = "#{Atlas::CONFIG.prefix}help | #{'Server'.pluralize(event.bot.servers.length)}"
            Atlas::DATABASE.query("DELETE FROM servers WHERE id = '#{event.server.id}'")
            logger.debug "Deleted record in database"
        	logger.info "Atlas has left #{event.server.name}"
        end
    end
end