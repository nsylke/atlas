module Atlas::Events
    module MemberJoin
        extend Discordrb::EventContainer

        member_join do |event|
            # break unless event.server.id == 443426973025304576

            # role = event.server.role(443485098722066432)
            # event.user.add_role role
            
            # Atlas::DATABASE.query("SELECT autorole FROM servers WHERE id = #{event.server.id}").each do |row|
            #     unless row['autorole'].nil?
            #         break unless Atlas::BOT.member(event.server, Atlas::BOT.profile).permission? :manage_roles
            #         id = row['autorole']
            #         role = event.server.role(id)
            #         break if event.user.role? role
            #         event.user.add_role role
            #     end
            # end
        end
    end
end