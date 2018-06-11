module Atlas::Commands
    module Suggestion
        extend Discordrb::Commands::CommandContainer

        bucket :rate_limit, limit: 1, time_span: 3600

        command([:suggestion, :suggest], bucket: :rate_limit) do |event, *args|
            return if event.author.bot_account?

            next "You can't suggest nothing..." if args.empty?

            args = args.join(' ')

            channel = Atlas::BOT.server(443426973025304576).channels.find { |c| c.id == 443612849236082711 }
            
            message = channel.send_embed do |embed|
                embed.title = 'Suggestion'
                embed.description = args.to_s
                embed.footer = {
                    icon_url: event.user.avatar_url,
                    text: event.user.distinct
                }
            end

            UP_ARROW = "\u2b06".freeze
            DOWN_ARROW = "\u2b07".freeze

            message.react UP_ARROW
            message.react DOWN_ARROW

            event.channel.send_embed do |embed|
                embed.title = 'Suggestion'
                embed.description = 'Successfully sent suggestion to Atlas server. [Click here](https://discord.gg/67taXWN) to join!'
            end
        end
    end
end