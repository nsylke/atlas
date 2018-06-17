module Atlas::Commands
    module Kick
        extend Discordrb::Commands::CommandContainer

        command(:kick) do |event, *args|
            return if event.author.bot_account?

            return "You don't have permission to use this command." unless event.author.permission? :kick_members
            return "Atlas doesn't have permission to kick members." unless event.bot.profile.on(event.server).permission? :kick_members

            args = args.join(' ').split(' ', 2)
            reason = args[1] || 'No reason specified.'

            user = event.message.mentions.first

            if user.nil?
                event.respond('Please specify a user to be kicked.')
                return
            end

            if !Atlas::BOT.member(event.server, user.id).roles.empty?
                if Atlas::BOT.member(event.server, user.id).roles.first.position >= Atlas::BOT.member(event.server, Atlas::BOT.profile.id).roles.first.position 
                    event.respond('Atlas is not allowed to kick that person.')
                    return 
                end

                if Atlas::BOT.member(event.server, user.id).roles.first.position >= event.author.roles.first.position
                    event.respond('You are not allowed to kick that person.')
                    return
                end
            end

            event.server.kick(user)
            event.respond("Successfully kicked #{user.distinct} from the server.")

            result = Atlas::DATABASE.query("SELECT modlog_id FROM servers WHERE id = #{event.server.id}")
            result.each do |row|
                return if row['modlog_id'].nil?

                channel = event.server.channels.find { |c| c.id == row['modlog_id'] }

                return "The channel for modlog couldn't be found." if channel.nil?

                channel.send_embed do |embed|
                    embed.add_field name: 'User', value: user.distinct, inline: true
                    embed.add_field name: 'Action', value: 'Kick', inline: true
                    embed.add_field name: 'Reason', value: reason.to_s, inline: false
                    embed.color = 0xff0000
                    embed.author = {
                        icon_url: event.author.avatar_url,
                        name: event.author.distinct
                    }
                end
            end

            nil
        end
    end
end