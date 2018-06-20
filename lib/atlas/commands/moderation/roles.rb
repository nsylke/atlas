module Atlas::Commands
    module Roles
        extend Discordrb::Commands::CommandContainer

        command(:roles) do |event, *args|
            return if event.author.bot_account?
            return "No arguments specified. Usage: `#{Atlas::CONFIG.prefix}roles <add/remove/list> [user] [role]`" if args.empty?

            args = args.join(' ').split(' ', 3)

            case args[0]
            when 'add', '+'
                return "You don't have permission to use this command." unless event.author.permission? :manage_roles
                return "Atlas doesn't have permission to manage roles." unless event.bot.profile.on(event.server).permission? :manage_roles
                return "Not enough arguments. Usage: #{Atlas::CONFIG.prefix}roles add [user] [role]" if args.length != 3

                user = event.message.mentions.first

                return "User couldn't be found." if user.nil?

                role = event.server.role(args[2].to_i)
                role = event.server.roles.find { |r| r.name == args[2].to_s } if role.nil?

                user = user.on(event.server)

                return "Role couldn't be found." if role.nil?
                return "#{user.name} already has the #{role.name} role." if user.role? role

                # Further inspection is required
                # check = (event.author == user ? event.author.roles.first.position : user.roles.first.position)
                # return "You can't add the role #{event.author == user ? 'to yourself' : "to #{user.name}"}." if check < role.position

                user.add_role(role)
                event.respond("Successfully given #{role.name} role to #{user.name}.")
            when 'remove', '-'
                return "You don't have permission to use this command." unless event.author.permission? :manage_roles
                return "Atlas doesn't have permission to manage roles." unless event.bot.profile.on(event.server).permission? :manage_roles
                return "Not enough arguments. Usage: #{Atlas::CONFIG.prefix}roles remove [user] [role]" if args.length != 3

                user = event.message.mentions.first

                return "User couldn't be found." if user.nil?

                role = event.server.role(args[2].to_i)
                role = event.server.roles.find { |r| r.name == args[2].to_s } if role.nil?

                user = user.on(event.server)

                return "Role couldn't be found." if role.nil?
                return "#{user.name} doesn't have the #{role.name} role." if !user.role? role

                user.remove_role(role)
                event.respond("Successfully removed #{role.name} role from #{user.name}.")
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