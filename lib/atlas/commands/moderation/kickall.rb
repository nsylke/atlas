module Atlas::Commands
    module Kickall
        extend Discordrb::Commands::CommandContainer

        command(:kickall) do |event|
            return if event.author.bot_account?
            
            break unless event.author.id == event.server.owner.id

            unless Atlas::BOT.member(event.server, Atlas::BOT.profile.id).permission? :kick_members
                event.respond("Atlas doesn't have permission to kick members.")
                break
            end

            message = event.respond("Are you sure you want to kick everyone? This action is irreversible.")

            event.user.await(/^(?:y(es)|n(o))$/i) do |answer|
                output = answer.message.content.to_s
                answer.message.delete

                if output =~ /^(?:y(es))$/i
                    event.server.members.each do |member|
                        if Atlas::BOT.member(event.server, user.id).roles.first.position >= Atlas::BOT.member(event.server, Atlas::BOT.profile.id).roles.first.position 
                            event.respond('Atlas is not allowed to kick that person.')
                            next
                        end

                        event.server.kick(member) unless member.id == event.author.id || member.current_bot? || member.owner?
                    end
                else
                    message.edit("Action canceled.")
                end
            end

            nil
        end
    end
end