module Atlas::Commands
    module Server
        extend Discordrb::Commands::CommandContainer

        command([:server, :s]) do |event|
            return if event.author.bot_account?

            server = event.server

            event.channel.send_embed do |embed|
                embed.thumbnail = { url: server.icon_url }
                embed.add_field name: 'Name', value: server.name, inline: true
                embed.add_field name: 'ID', value: server.id, inline: true
                embed.add_field name: 'Owner', value: "#{server.owner.distinct}", inline: true
                embed.add_field name: 'Region', value: server.region, inline: true
                embed.add_field name: 'Online Members', value: server.online_members.count, inline: true
                embed.add_field name: 'Members', value: server.member_count, inline: true
                embed.add_field name: 'Channels', value: server.channels.length, inline: true
                embed.add_field name: 'Verification', value: server.verification_level.to_s.capitalize, inline: true
                embed.add_field name: 'Roles', value: server.roles.length, inline: true
                embed.add_field name: 'Emojis', value: server.emojis.length, inline: true
            end
        end
    end
end