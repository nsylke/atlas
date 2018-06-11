module Atlas::Commands
    module Eightball
        extend Discordrb::Commands::CommandContainer

        command([:eightball, :'8ball']) do |event|
            return if event.author.bot_account?

            event.respond(answers[rand(answers.size)])
        end

        module_function

        def answers
            [
                "It is certain",
                "It is decidedly so",
                "Without a doubt",
                "Yes definitely",
                "You may rely on it",
                "As I see it, yes",
                "Most likely",
                "Outlook good",
                "Yes",
                "Signs point to yes",
                "Reply hazy try again",
                "Ask again later",
                "Better not tell you now",
                "Cannot predict now",
                "Concentrate and ask again",
                "Don't count on it",
                "My reply is no",
                "My sources say no",
                "Outlook not so good",
                "Very doubtful"
            ]
        end
    end
end