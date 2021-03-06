module Atlas::Commands
    module Role
        extend Discordrb::Commands::CommandContainer

        command([:role, :r]) do |event, args|
            return if event.author.bot_account?

            return "Please specify a role." if args.nil?

            role = event.server.roles.find { |r| r.name == args }

            return "Role couldn't be found." if role.nil?

            event.channel.send_embed do |embed|
                embed.title = role.name
                embed.add_field name: 'ID', value: role.id, inline: true
                embed.add_field name: 'Hoist', value: role.hoist, inline: true
                embed.add_field name: 'Mentionable', value: role.mentionable, inline: true
                embed.add_field name: 'Position', value: role.position, inline: true
                embed.add_field name: 'Creation Time', value: role.creation_time.strftime("%b %d, %Y"), inline: true
                embed.add_field name: 'Permissions', value: "#{role.permissions.bits} ([Calc](https://discordapi.com/permissions.html##{role.permissions.bits}))", inline: true
                embed.add_field name: 'Members', value: (!role.members.empty? ? role.members.map(&:name).join(', ')[0..900].gsub(/[^\w]\w+\s*$/, '...') : 'None'), inline: false
                embed.color = role.color.combined
            end
        end
    end
end