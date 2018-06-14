module Atlas::Commands
    module Settings
        extend Discordrb::Commands::CommandContainer

        # command(:test) do |event|
        #     break unless event.author.id == 187342661060001792

        #     message = event.respond("Welcome to Atlas's interactive setting command! What are you looking to do today?\n\nA. Edit a setting\nB. View a setting")
            
        #     response0 = event.message.await!(timeout: 3)

        #     if response0
        #         if response0.message.content == 'B'
        #             Atlas::DATABASE.query("SELECT modlog_id FROM servers WHERE id = #{event.server.id}").each do |row|
        #                 if row['modlog_id'].nil?
        #                     message.edit("Uh oh! Looks like you haven't set a channel to modlog yet. Please rerun this command to do so.")
        #                     return
        #                 end

        #                 message.edit("We found it! Moderation logs are being sent to <##{row['modlog_id']}>!")
        #             end
        #         else
        #             message.edit("Action not found.")
        #         end
        #     else
        #         message.edit("Response took too long, action canceled.")
        #     end
        # end

        command([:settings, :set]) do |event, *args|
            return if event.author.bot_account?

            break unless event.author.id == event.server.owner.id || event.author.id == 187342661060001792
            
            args = args.join(' ').split(' ', 3)

            case args[0]
            when 'edit'
                case args[1]
                when 'modlog'
                    if args[2].nil?
                        event.respond('Please specify a channel id to be used for modlogs.')
                        return
                    end

                    channel = event.server.channels.find { |c| c.id == args[2].to_i }

                    if channel.nil?
                        event.respond('Invalid channel id, please try again.')
                        return
                    end

                    Atlas::DATABASE.query("UPDATE servers SET modlog_id = #{channel.id} WHERE id = #{event.server.id}")
                    event.respond("Successfully updated modlog to <##{channel.id}>.")
                when 'autorole'
                    if args[2].nil?
                        event.respond('Please specify a role id to be used for autorole.')
                        return
                    end

                    role = event.server.roles.find { |r| r.id == args[2].to_i }

                    if role.nil?
                        event.respond('Invalid role id, please try again.')
                        return
                    end

                    Atlas::DATABASE.query("UPDATE servers SET autorole = #{role.id} WHERE id = #{event.server.id}")
                    event.respond("Successfully updated autorole to #{role.name}.")
                else
                    event.respond("That setting doesn't exist.")
                end
            when 'view'
                case args[1]
                when 'modlog'
                    result = Atlas::DATABASE.query("SELECT modlog_id FROM servers WHERE id = #{event.server.id}")

                    result.each do |res|
                        if res['modlog_id'].nil?
                            event.respond("You haven't set a channel for modlog yet.")
                            return
                        end

                        event.respond("The current channel for modlog is <##{res['modlog_id']}>.")
                    end

                    nil
                when 'autorole'
                    result = Atlas::DATABASE.query("SELECT autorole FROM servers WHERE id = #{event.server.id}")

                    result.each do |res|
                        if res['autorole'].nil?
                            event.respond("You haven't set a role for autorole yet.")
                            return
                        end

                        role = event.server.roles.find { |r| r.id == res['autorole'] }

                        if role.nil?
                            event.respond("The current role for autorole doesn't exist anymore.")
                            return
                        end

                        event.respond("The current role for autorole is #{role.name}.")
                    end

                    nil
                else
                    event.respond("That setting doesn't exist.")
                end
            else
                event.respond('Invalid command action.')
            end
        end
    end
end