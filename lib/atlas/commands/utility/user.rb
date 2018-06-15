module Atlas::Commands
    module User
        extend Discordrb::Commands::CommandContainer

        command([:user, :u, :whois, :whoami, :whoareyou]) do |event|
            return if event.author.bot_account?

            user = event.message.mentions.first

            if user.nil?
                user = event.author
            end

            if user.game.nil?
                game = 'N/A'
            else
                game = user.game
            end

            if Atlas::BOT.member(event.server, user.id).nick.nil?
                nick = 'N/A'
            else
                nick = Atlas::BOT.member(event.server, user.id).nick
            end

            roles = Atlas::BOT.member(event.server, user.id).roles

            event.channel.send_embed do |embed|
                embed.thumbnail = { url: user.avatar_url }
                embed.add_field name: 'Username', value: user.name, inline: true
                embed.add_field name: 'Nickname', value: nick, inline: true
                embed.add_field name: 'Discriminator', value: user.discriminator, inline: true
                embed.add_field name: 'ID', value: user.id, inline: true
                embed.add_field name: 'Registered', value: user.creation_time.strftime('%b %d, %Y'), inline: true
                embed.add_field name: 'Joined', value: Atlas::BOT.member(event.server, user.id).joined_at.strftime('%b %d, %Y'), inline: true
                embed.add_field name: 'Status', value: user.status.capitalize, inline: true
                embed.add_field name: 'Playing', value: game, inline: true
                embed.add_field name: 'Roles', value: roles.sort_by(&:position).reverse!.map(&:name).join(', '), inline: false if !roles.empty?
            end
        end
    end
end