module Atlas::Events
    module ServerCreate
        extend Discordrb::EventContainer

        server_create do |event|
        	event.bot.game = "#{Atlas::CONFIG.prefix}help | #{'Server'.pluralize(event.bot.servers.length)}"
            Atlas::DATABASE.query("INSERT INTO servers (id) VALUES ('#{event.server.id}') ON DUPLICATE KEY UPDATE id = '#{event.server.id}'")
        end
    end
end