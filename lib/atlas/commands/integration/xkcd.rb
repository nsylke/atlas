module Atlas::Commands
    module Xkcd
        extend Discordrb::Commands::CommandContainer

        command(:xkcd) do |event, number|
            return if event.author.bot_account?

            if number.to_i > 2004
                event.respond('Number too large, highest number available is 2004.')
                break
            end

            comic   = ::Xkcd.latest if number == 'latest'
            comic ||= ::Xkcd.fetch(number.to_i) if number
            comic ||= ::Xkcd.random

            event.channel.send_embed do |e|
                e.title       = comic.title
                e.description = "#{comic.alt} [(Explain)](#{comic.explain_url})"
                e.url         = comic.xkcd_url
                e.color       = 3447003
                e.timestamp   = comic.time.utc
                e.image       = { url: comic.image_url }
                e.footer      = { text: "xkcd ##{comic.number}", icon_url: 'http://xkcd.com/s/919f27.ico' }
            end
        end
    end
end