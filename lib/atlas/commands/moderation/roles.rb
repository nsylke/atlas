module Atlas::Commands
    module Roles
        extend Discordrb::Commands::CommandContainer

        command(:roles) do |event, *args|
            return if event.author.bot_account?
            return "No arguments specified. Usage: `#{Atlas::CONFIG.prefix}roles <add/remove/list> [user] [role]`" if args.empty?

            case args[0]
            when 'add'
            when 'remove'
            when 'list'
                roles = event.server.roles

                return "There is no roles to display." if roles.empty?

                event << 'List of roles:'
                count = 0
                roles.sort { |a, b| 
                    b.position <=> a.position 
                }.each { |r|
                    count = count + 1
                    event << "#{count}. #{r.name.gsub('@', '')}"
                }
                nil
            else
                event.respond("Incorrect usage. Usage: `#{Atlas::CONFIG.prefix}roles <add/remove/list> [user] [role]`")
            end
        end
    end
end