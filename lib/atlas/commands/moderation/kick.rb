module Atlas::Commands
    module Kick
        extend Discordrb::Commands::CommandContainer

        command(:kick) do |event, *args|
            return if event.author.bot_account?

            unless event.author.permission? :kick_members
                event.respond("You don't have permission to use this command.")
                break
            end

            unless Atlas::BOT.member(event.server, Atlas::BOT.profile.id).permission? :kick_members
                event.respond("Atlas doesn't have permission to kick members.")
                break
            end

            args = args.join(' ').split(' ', 2)
            if args[1].nil?
                args = 'No reason specified.'
            end

            user = event.message.mentions.first

            if user.nil?
                event.respond('Please specify a user to be kicked.')
                return
            end

            if Atlas::BOT.member(event.server, user.id).roles.first.position >= Atlas::BOT.member(event.server, Atlas::BOT.profile.id).roles.first.position 
                event.respond('Atlas is not allowed to kick that person.')
                return 
            end

            if Atlas::BOT.member(event.server, user.id).roles.first.position >= event.author.roles.first.position
                event.respond('You are not allowed to kick that person.')
                return
            end

            message = event.respond("Are you sure you want to kick #{user.distinct}?")

            event.user.await(/^(?:y(es)|n(o))$/i) do |answer|
                output = answer.message.content.to_s
                answer.message.delete

                if output =~ /^(?:y(es))$/i
                    message.edit("Successfully kicked #{user.distinct} from the server.")
                    event.server.kick(user)

                    result = Atlas::DATABASE.query("SELECT modlog_id FROM servers WHERE id = #{event.server.id}")

                    result.each do |row|
                        break if row['modlog_id'].nil?
                        
                        channel = Atlas::BOT.server(event.server.id).channels.find { |c| c.id == row['modlog_id'] }

                        channel.send_embed do |embed|
                            embed.add_field(name: 'User', value: user.distinct, inline: true)
                            embed.add_field(name: 'Action', value: 'Kick', inline: true)
                            embed.add_field(name: 'Reason', value: args[1].to_s, inline: false)
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