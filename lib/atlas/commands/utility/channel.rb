module Atlas::Commands
    module Channel
        extend Discordrb::Commands::CommandContainer

        command([:channel, :c]) do |event, args|
            return if event.author.bot_account?

            return "Please specify a channel." if args.nil?
            
            # Type 4 is a category and causes issues with topic being blank
            channel = event.server.channels.find { |c| c.name == args && c.type != 4 }
            channel = event.bot.find_channel(args, event.server.name).first if channel.nil?

            return "Couldn't find channel." if channel.nil?

            event.channel.send_embed do |embed|
                embed.title = channel.name
                embed.description = channel.topic || 'No topic available.'
                embed.add_field name: 'ID', value: channel.id, inline: true
                embed.add_field name: 'Type', value: (channel.type == 0 ? 'Text' : 'Voice'), inline: true
                embed.add_field name: 'Position', value: channel.position, inline: true
            end
        end
    end
end