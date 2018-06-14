module Atlas::Commands
    module Documentation
        extend Discordrb::Commands::CommandContainer

        command([:documentation, :doc, :docs, :syntax]) do |event, command|
            return if event.author.bot_account?

            command ? find(event, command) : 'Please specify a command.'
        end

        class << self
        	private

        	def find(event, name)
        		command = event.bot.commands[name.to_sym]

        		return "The command `#{name}` does not exist." unless command

        		usage, parameters = command.attributes.values_at(:usage, :parameters)

        		event.channel.send_embed do |embed|
        			embed.title = "Documentation for #{name}"
        			embed.add_field(name: 'Name', value: "#{name}", inline: true)
        			embed.add_field(name: 'Usage', value: "#{usage ? Atlas::CONFIG.prefix + usage : 'n/a'}", inline: true)
        			embed.add_field(name: 'Description', value: "#{command.attributes[:description] || 'No description available.'}", inline: false)
                    embed.add_field(name: 'Parameters', value: "#{parameters.join("\n")}", inline: false) if parameters
                end
        	end
        end
    end
end