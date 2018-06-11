module Atlas::Commands
    module Urban
        extend Discordrb::Commands::CommandContainer

        command([:urban, :urbandictionary, :ud]) do |event, *args|
            return if event.author.bot_account?

            term = args.join(' ')
            word   = UrbanDictionary.random.first if term.empty?
            word ||= UrbanDictionary.define(term).first
            next "Couldn't find anything for `#{term}`" unless word

            event.channel.send_embed do |e|
                e.description = '**Too long to display! Visit the URL by clicking above.**' if word.long?
                e.add_field name: 'Definition', value: word.text, inline: false unless word.long?
                e.add_field name: 'Example', value: "*#{word.example}*", inline: false if word.example unless word.long?
                e.add_field name: "\u200B", value: ":arrow_up: `#{word.thumbs_up}` :arrow_down: `#{word.thumbs_down}`", inline: false
                e.author = {
                    icon_url: 'http://www.dimensionalbranding.com/userfiles/urban_dictionary.jpg',
                    name: word.word,
                    url: word.url
                }
                e.footer = { text: "Author: #{word.author}"}
                e.color = 5800090
            end
        end
    end
end