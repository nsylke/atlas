module Atlas
    module Commands
        include Atlas::Loggable

        # Load all command files
        Dir["#{File.dirname(__FILE__)}/commands/*/*.rb"].each { |c| load c }

        # Pre-register commands
        @fun = [
            Choose,
            Eightball,
            Emoji,
            Emojify,
            Faces,
            Flip,
            Jokes,
            Nato,
            Random,
            Reverse,
            RockPaperScissors,
            Roll,
            Roman,
            ThisOrThat,
            WouldYouRather,
            Zalgo
        ]

        @general = [
            About,
            Commands,
            Documentation,
            Donate,
            Help,
            Home,
            Invite,
            Ping,
            Servers,
            Subscribe,
            Suggestion,
            Unsubscribe,
            Uptime,
            Version
        ]

        @integration = [
            DuckDuckGo,
            Lmgtfy,
            Urban,
            Xkcd
        ]

        @miscellaneous = [
            Say
        ]

        @moderation = [
            Ban,
            Kick,
            Prune,
            Roles,
            Settings,
            Unban
        ]

        @utility = [
            Channel,
            Role,
            Server,
            User
        ]

        def self.register!
            # Probably a better way of doing this
            all.each do |mod|
                Atlas::BOT.include!(mod)
            end

            logger.debug "Registered #{all.count} commands."
        end

        private

        def self.all
            @fun + @general + @integration + @miscellaneous + @moderation + @utility
        end
    end
end