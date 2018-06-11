module Atlas::Events
    module Mention
        extend Discordrb::EventContainer

        mention do |event|
            event.respond("The prefix for Atlas is #{Atlas::CONFIG.prefix}")
        end
    end
end