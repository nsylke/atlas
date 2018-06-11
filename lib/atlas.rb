require 'discordrb'
require 'yaml'
require 'net/http'
require 'uri'
require 'json'
require 'mysql2'

require_relative 'ext/string'

module Kernel
    @start_time = Time.now

    def run_supressed(&block)
        original_verbosity = $VERBOSE
        $VERBOSE = nil
        yield block
        $VERBOSE = original_verbosity
    end

    def uptime(short = false)
        secs = (Time.now - @start_time).to_i
        days = secs / 86400
        secs -= days * 86400
        hours = secs / 3600
        secs -= hours * 3600
        mins  = secs / 60
        secs -= mins * 60

        if short
            "#{days}d, #{hours}h, #{mins}m, #{secs}s"
        else
            days = "#{days} day#{'s' unless days == 1}"
            hours = "#{hours} hour#{'s' unless hours == 1}"
            mins = "#{mins} minute#{'s' unless mins == 1}"
            secs = "#{secs} second#{'s' unless secs == 1}"

            "#{days}, #{hours}, #{mins} and #{secs}"
        end
    end

    def stats(url, authorization, servers)
        body = {}
        body["server_count"] = servers

        uri = URI.parse(url)
        request = Net::HTTP::Post.new(uri)
        request["Authorization"] = "#{authorization}"
        request["Content-Type"] = 'application/json'
        request.body = JSON.dump(body)

        req_options = {
            use_ssl: uri.scheme == 'https'
        }

        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
            http.request(request)
        end
    end
end

module Atlas
    # # Initialize logger
    # run_supressed { Discordrb::LOG_TIMESTAMP_FORMAT = '%Y-%m-%d %H:%M:%S' }

    # # Enable debug mode if started with `ruby run.rb -d`
    # debug = ARGV.include?('-d') ? :debug : false
    # log_streams = [STDOUT]

    # if debug 
    #     timestamp = Time.now.strftime(Discordrb::LOG_TIMESTAMP_FORMAT.tr(':', '-'))
    #     log_file = File.new("#{Dir.pwd}/logs/#{timestamp}.log", 'a+')
    #     log_streams.push(log_file)
    # end

    # run_supressed { LOGGER = Discordrb::LOGGER = Discordrb::Logger.new(nil, log_streams) }

    # LOGGER.debug = true if debug

    # Load modules
    Dir["#{File.dirname(__FILE__)}/atlas/*.rb"].each { |f| require_relative f }
    Dir["#{File.dirname(__FILE__)}/integrations/*.rb"].each { |f| require_relative f }

    # Initialize logger
    LOGGER = Logger.new

    # Initialize config
    CONFIG = Config.new 

    # Initialize mysql2
    DATABASE = Mysql2::Client.new(host: CONFIG.database['host'], database: CONFIG.database['name'], username: CONFIG.database['user'], password: CONFIG.database['pass'], reconnect: true)

    # Initialize bot
    BOT = Discordrb::Commands::CommandBot.new(token: "Bot #{CONFIG.token}", client_id: CONFIG.client_id, prefix: CONFIG.prefix, parse_self: false, help_command: false, advanced_functionality: false)

    # Register events and commands
    Events.include!
    Commands.registerFunCommands!
    Commands.registerGeneralCommands!
    Commands.registerIntegrationCommands!
    Commands.registerModerationCommands!

    # Safe exit
    at_exit do
        LOGGER.info('Exiting...') 
        exit!
    end

    # Safe command incase anything breaks.
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
        when 'stats'
            m = event.respond('Updating stats...');
            Kernel.stats('https://discordbots.org/api/bots/212744072073314304/stats', CONFIG.tokens['discordbots_org'], BOT.servers.length)
            m.edit('Updated stats.');
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

    # Start bot
    BOT.run
end