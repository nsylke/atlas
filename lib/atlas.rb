require 'discordrb'

require 'logger'
require 'yaml'
require 'mysql2'
require 'time'

require_relative 'ext/string'

require_relative 'atlas/version'
require_relative 'atlas/support/loggable'
require_relative 'atlas/support/uptime'
require_relative 'atlas/config'
require_relative 'atlas/logger'

require_relative 'integrations/urban'
require_relative 'integrations/xkcd'

require_relative 'atlas/commands'
require_relative 'atlas/events'

module Atlas
    UPTIME = Uptime.new

    block_given? ? yield(AtlasLogger) : AtlasLogger

    include Loggable

    CONFIG = Config.new
    logger.debug "Loaded configuration file."

    DATABASE = Mysql2::Client.new(host: CONFIG.database['host'], database: CONFIG.database['name'], username: CONFIG.database['user'], password: CONFIG.database['pass'], reconnect: true)
    logger.debug "Started MySQL client."

    BOT = Discordrb::Commands::CommandBot.new(token: "Bot #{CONFIG.token}", client_id: CONFIG.client_id, prefix: CONFIG.prefix, parse_self: false, help_command: false, advanced_functionality: false)

    ### TODO: Clean this up
    Events.include!
    Commands.registerFunCommands!
    Commands.registerGeneralCommands!
    Commands.registerIntegrationCommands!
    Commands.registerModerationCommands!
    ###

    at_exit do
        logger.info "Stopping instance of Atlas..."
        exit!
    end

    ### TODO: Clean this up
    BOT.command(:sudo) do |event, *args|
        break unless event.user.id == 187342661060001792

        args = args.join(' ').split(' ', 2)

        case args[0]
        when 'eval'
            output = eval(args[1])

            begin
                event.respond(output.to_s)
            rescue => e
                event.respond('An error occurred. Sending backtrace in private message.')
                event.author.pm(e.backtrace)
            end
        # when 'stats'
        #     m = event.respond('Updating stats...');
        #     Kernel.stats('https://discordbots.org/api/bots/212744072073314304/stats', CONFIG.tokens['discordbots_org'], BOT.servers.length)
        #     m.edit('Updated stats.');
        when 'update'
            output = `git pull`
            if output.match? 'Already up-to-date'
                event.respond('Atlas is already up-to-date.')
            else
                event.respond('Restarting Atlas...')
                exec('pm2 restart Beta')
            end
        when 'restart'
            if args[1] == 'stable'
                event.respond('Restarting Atlas...')
                exec('pm2 restart Atlas')
            elsif args[1] == 'beta'
                event.respond('Restarting Atlas Beta...')
                exec('pm2 restart Beta')
            else
                event.respond('Invalid command action.')
            end
        else
            event.respond('Invalid command action.')
        end
    end
    ###

    logger.info "Starting instance of Atlas..."
    BOT.run
end