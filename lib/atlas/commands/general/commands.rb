require 'simply_paginate'

module Atlas::Commands
    module Commands
        extend Discordrb::Commands::CommandContainer

        command([:commands, :cmds]) do |event, args|
            return if event.author.bot_account?
            
            if args.nil?
                args = 1
            end

            count = (commands.size/10.to_f).ceil
            prefix = Atlas::CONFIG.prefix

            next "That page doesn't exist." unless args.to_i <= count

            page = SimplyPaginate::Page.new(args.to_i, commands, 10)

            event << '**Commands:**'
            event << ''

            page.elements.each do |element|
                event << "#{prefix}#{element}"
            end

            event << ''
            event << "Page #{args.to_i} of #{count}"

        end

        module_function

        def commands
            [
                "about",
                "ban <user> [reason]",
                "commands",
                "channel <channel>",
                "choose <choice, choice>",
                "docs [command]",
                "donate",
                "8ball [question]",
                "emoji <emoji>",
                "emojify <message>",
                "faces",
                "flip",
                "help",
                "home",
                "invite",
                "jokes",
                "kick <user> [reason]",
                "lmgtfy <query>",
                "nato <message>",
                "ping",
                "prune <amount>",
                "random [min] [max]",
                "reverse <message>",
                "rockpaperscissors",
                "role <role>",
                "roll <dice>",
                "roman <number>",
                "say <message>",
                "server",
                "servers",
                "settings <edit/view> <setting> [value]",
                "subscribe",
                "suggestion <message>",
                "thisorthat",
                "unban <user>",
                "unsubscribe",
                "uptime",
                "urban [word]",
                "user [user]",
                "version",
                "wouldyourather",
                "xkcd [number]",
                "zalgo <message>"
            ]
        end
    end
end