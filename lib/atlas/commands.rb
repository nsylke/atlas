module Atlas
    module Commands
        include Atlas::Loggable

        # Load all command files
        Dir["#{File.dirname(__FILE__)}/commands/fun/*.rb"].each { |c| load c }
        Dir["#{File.dirname(__FILE__)}/commands/general/*.rb"].each { |c| load c }
        Dir["#{File.dirname(__FILE__)}/commands/integration/*.rb"].each { |c| load c }
        Dir["#{File.dirname(__FILE__)}/commands/miscellaneous/*.rb"].each { |c| load c }
        Dir["#{File.dirname(__FILE__)}/commands/moderation/*.rb"].each { |c| load c }
        Dir["#{File.dirname(__FILE__)}/commands/utility/*.rb"].each { |c| load c }

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
            User,
            Version
        ]

        @integration = [
            Urban,
            Xkcd
        ]

        @miscellaneous = [
            Say
        ]

        @moderation = [
            Ban,
            Kick,
            Kickall,
            Prune,
            Settings,
            Unban
        ]

        @utility = [
            Server,
        ]

        # Register commands
        def self.registerFunCommands!
            @fun.each do |c|
                Atlas::BOT.include!(c)
            end

            logger.debug "Registered #{@fun.count} fun commands."
        end

        def self.registerGeneralCommands!
            @general.each do |c|
                Atlas::BOT.include!(c)
            end

            logger.debug "Registered #{@general.count} general commands."
        end

        def self.registerIntegrationCommands!
            @integration.each do |c|
                Atlas::BOT.include!(c)
            end

            logger.debug "Registered #{@integration.count} integration commands."
        end

        def self.registerMiscellaneousCommands!
            @miscellaneous.each do |c|
                Atlas::BOT.include!(c)
            end

            logger.debug "Registered #{@miscellaneous.count} miscellaneous commands."
        end

        def self.registerModerationCommands!
            @moderation.each do |c|
                Atlas::BOT.include!(c)
            end

            logger.debug "Registered #{@moderation.count} moderation commands."
        end

        def self.registerUtilityCommands!
            @utility.each do |c|
                Atlas::BOT.include!(c)
            end

            logger.debug "Registered #{@utility.count} utility commands."
        end
    end
end