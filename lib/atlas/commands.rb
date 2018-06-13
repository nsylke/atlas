module Atlas
    module Commands
        # Load all command files
        Dir["#{File.dirname(__FILE__)}/commands/fun/*.rb"].each { |c| load c }
        Dir["#{File.dirname(__FILE__)}/commands/general/*.rb"].each { |c| load c }
        Dir["#{File.dirname(__FILE__)}/commands/integration/*.rb"].each { |c| load c }
        Dir["#{File.dirname(__FILE__)}/commands/moderation/*.rb"].each { |c| load c }

        # Pre-register commands
        @fun = [
            Choose,
            Eightball,
            Emoji,
            Faces,
            Flip,
            Jokes,
            Lmgtfy,
            Nato,
            Random,
            Reverse,
            RockPaperScissors,
            Roll,
            Say,
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
            Server,
            Servers,
            Subscribe,
            Suggestion,
            Unsubscribe,
            Uptime,
            User,
            Version
        ]

        @integration = [
            Urban,
            Xkcd
        ]

        @moderation = [
            Ban,
            Kick,
            Kickall,
            Prune,
            Settings,
            Unban
        ]

        # Register commands
        def self.registerFunCommands!
            @fun.each do |c|
                Atlas::BOT.include!(c)
            end
        end

        def self.registerGeneralCommands!
            @general.each do |c|
                Atlas::BOT.include!(c)
            end
        end

        def self.registerIntegrationCommands!
            @integration.each do |c|
                Atlas::BOT.include!(c)
            end
        end

        def self.registerModerationCommands!
            @moderation.each do |c|
                Atlas::BOT.include!(c)
            end
        end
    end
end