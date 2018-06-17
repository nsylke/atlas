module Atlas::Commands
    module Unban
        extend Discordrb::Commands::CommandContainer

        command([:unban, :pardon]) do |event|
            return if event.author.bot_account?

            return "You don't have permission to use this command." unless event.author.permission? :ban_members
            return "Atlas doesn't have permission to ban members." unless event.bot.profile.on(event.server).permission? :ban_members

            user = event.message.mentions.first

            if user.nil?
                event.respond('Please specify a user to be unbanned.')
                return
            end

            event.server.unban(user)
            event.respond("Successfully unbanned #{user.distinct} from the server.")

            result = Atlas::DATABASE.query("SELECT modlog_id FROM servers WHERE id = #{event.server.id}")
            result.each do |row|
                return if row['modlog_id'].nil?

                channel = event.server.channels.find { |c| c.id == row['modlog_id'] }

                return "The channel for modlog couldn't be found." if channel.nil?

                channel.send_embed do |embed|
                    embed.add_field name: 'User', value: user.distinct, inline: true
                    embed.add_field name: 'Action', value: 'Unban', inline: true
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