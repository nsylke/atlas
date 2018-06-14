module Atlas::Commands
    module About
        extend Discordrb::Commands::CommandContainer

        command([:about, :info]) do |event|
            return if event.author.bot_account?

            event.channel.send_embed do |embed|
                embed.title = 'Information about Atlas'
                embed.add_field(name: 'Creator', value: 'Nick#4490', inline: true)
                embed.add_field(name: 'Servers', value: Atlas::BOT.servers.length, inline: true)
                embed.add_field(name: 'Users', value: Atlas::BOT.users.length, inline: true)
                embed.add_field(name: 'Uptime', value: Atlas::UPTIME.uptime, inline: true)
                embed.add_field(name: 'OAuth Invite', value: '[Click here](https://discordapp.com/oauth2/authorize?&client_id=212744072073314304&scope=bot&permissions=268443670)', inline: true)
                embed.add_field(name: 'Support Server', value: '[Click here](https://discord.gg/67taXWN)', inline: true)
                embed.add_field(name: 'Version', value: Atlas::VERSION, inline: true)
                embed.color = 344703
                embed.footer = {
                    icon_url: Atlas::BOT.profile.avatar_url,
                    text: 'Atlas Support'
                }
            end
        end
    end
end