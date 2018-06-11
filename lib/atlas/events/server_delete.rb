module Atlas::Events
    module ServerDelete
        extend Discordrb::EventContainer

        server_delete do |event|
        	event.bot.game = "#{Atlas::CONFIG.prefix}help | #{'Server'.pluralize(event.bot.servers.length)}"
            Atlas::DATABASE.query("DELETE FROM servers WHERE id = '#{event.server.id}'")
        end
    end
end