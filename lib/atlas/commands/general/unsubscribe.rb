module Atlas::Commands
    module Unsubscribe
        extend Discordrb::Commands::CommandContainer

        command(:unsubscribe) do |event|
            return if event.author.bot_account?
            break unless event.server.id == 443426973025304576

            role = event.server.roles.find { |r| r.name == 'Subscriber' }

            author = event.author.on(event.server)

            break unless author.role?(role)

            author.remove_role role
            event.respond('Successfully unsubscribed to Atlas announcements.')
        end
    end
end