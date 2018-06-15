module Atlas::Commands
    module Channel
        extend Discordrb::Commands::CommandContainer

        command([:channel, :c]) do |event, args|
            return if event.author.bot_account?

            return "Please specify a channel." if args.nil?

            channel = event.bot.find_channel(args, event.server).first

            return "Channel couldn't be found." if channel.nil?

            event.channel.send_embed do |embed|
                embed.title = channel.name
                embed.description = channel.topic
                embed.add_field name: 'ID', value: channel.id, inline: true
                embed.add_field name: 'Type', value: (channel.type == 0 ? 'Text' : 'Voice'), inline: true
                embed.add_field name: 'Position', value: channel.position, inline: true
            end
        end
    end
end