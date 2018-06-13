module Atlas::Commands
    module Help
        extend Discordrb::Commands::CommandContainer

        command([:help, :h, :'?']) do |event|
            return if event.author.bot_account?

            prefix = Atlas::CONFIG.prefix

            event << 'Welcome to Atlas!'
            event << ''
            event << 'If this is your first time using Atlas, you should definitely'
            event << 'check out the documentation by using the following command:'
            event << "  `#{prefix}doc [command]`"
            event << ''
            event << 'If further assistance is needed, you should check out the Atlas'
            event << 'official server by using the following command:'
            event << "  `#{prefix}home`"
            event << ''
            event << 'For a list of commands use the following command:'
            event << "  `#{prefix}commands`"
        end
    end
end