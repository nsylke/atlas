module Atlas::Commands
    module Unban
        extend Discordrb::Commands::CommandContainer

        command(:unban) do |event|
            return if event.author.bot_account?

            unless event.author.permission? :ban_members
                event.respond("You don't have permission to use this command.")
                break
            end

            unless Atlas::BOT.member(event.server, Atlas::BOT.profile.id).permission? :ban_members
                event.respond("Atlas doesn't have permission to ban members.")
                break
            end

            user = event.message.mentions.first

            if user.nil?
                event.respond('Please specify a user to be unbanned.')
                return
            end

            message = event.respond("Are you sure you want to unban #{user.distinct}?")

            event.user.await(/^(?:y(es)|n(o))$/i) do |answer|
                output = answer.message.content.to_s
                answer.message.delete

                if output =~ /^(?:y(es))$/i
                    message.edit("Successfully unbanned #{user.distinct} from the server.")
                    event.server.unban(user)

                    result = Atlas::DATABASE.query("SELECT modlog_id FROM servers WHERE id = #{event.server.id}")

                    result.each do |row|
                        break if row['modlog_id'].nil?
                        
                        channel = Atlas::BOT.server(event.server.id).channels.find { |c| c.id == row['modlog_id'] }

                        channel.send_embed do |embed|
                            embed.add_field(name: 'User', value: user.distinct, inline: true)
                            embed.add_field(name: 'Action', value: 'Unban', inline: true)
                            embed.color = 0xff0000
                            embed.author = {
                                icon_url: event.author.avatar_url,
                                name: event.author.distinct
                            }
                        end
                    end
                else
                    message.edit("Action canceled.")
                end
            end

            nil
        end
    end
end