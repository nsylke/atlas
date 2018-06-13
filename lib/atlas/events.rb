module Atlas
    module Events
        include Atlas::Loggable

        # Load all event files
        Dir["#{File.dirname(__FILE__)}/events/*.rb"].each { |c| load c }

        # Pre-register events
        @events = [
            MemberJoin,
            Mention,
            Ready,
            ServerCreate,
            ServerDelete
        ]

        # Register events
        def self.include!
            @events.each do |e|
                Atlas::BOT.include!(e)
            end

            logger.debug "Registered #{@events.count} events."
        end
    end
end