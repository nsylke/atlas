module Atlas::Events
    module MemberJoin
        extend Discordrb::EventContainer

        member_join do |event|
            Atlas::DATABASE.query("SELECT autorole FROM servers WHERE id = #{event.server.id}").each do |row|
                break if row['autorole'].nil?

                id, name = row['autorole'].split('|')

                role = event.server.role(id.to_i)
                role = event.server.roles.find { |r| r.name == name.to_s }

                break if role.nil?

                event.user.add_role role
            end
        end
    end
end