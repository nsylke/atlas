module Atlas::Commands
    module Subscribe
        extend Discordrb::Commands::CommandContainer

        command(:subscribe) do |event|
            return if event.author.bot_account?
            break unless event.server.id == 443426973025304576

            role = event.server.roles.find { |r| r.name == 'Subscriber' }

            author = event.author.on(event.server)

            break if author.role?(role)

            author.add_role role
            event.respond('Successfully subscribed to Atlas announcements.')
        end
    end
end