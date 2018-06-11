module Atlas::Commands
	module Emoji
		extend Discordrb::Commands::CommandContainer

		command(:emoji) do |event, emoji|
			val = ''

			if emoji
				emoji.match /<:[[[:alnum:]]_]+:[[:digit:]]+>/ do |e|
					parts = e.to_s.split ':'
					val = "https://cdn.discordapp.com/emojis/#{parts[parts.length - 1].gsub('>', '')}.png"
				end
				val = 'No server emoji specified.' if val == ''
			else
				val = 'No server emoji specified.'
			end
			event.respond val
		end
	end
end