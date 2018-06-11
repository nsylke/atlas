module Atlas::Commands
    module Roll
        extend Discordrb::Commands::CommandContainer

        command([:roll, :dice]) do |event, dice|
            return if event.author.bot_account?

            begin 
                number, sides = dice.split('d')
            rescue NoMethodError
                next 'Invalid arguments, try: `roll 2d6`.'
            end

            next 'Invalid arguments, try: `roll 2d6`.' unless number && sides

            begin 
                number = Integer(number)
                sides = Integer(sides)
            rescue ArgumentError
                next 'Invalid arguments, try `roll 2d6`.'
            end

            if number.zero?
                event.respond('Dice to small, must be 1 or more.')
                break
            elsif number > 100
                event.respond('Dice to large, must be 100 or less.')
                break
            end

            if sides.zero?
                event.respond('Sides to small, must be 2 or more.')
                break
            elsif sides == 1
                event.respond('Sides to small, must be 2 or more.')
                break
            elsif sides > 1000
                event.respond('Sides to large, must be 1000 or less.')
                break
            end

            rolls = Array.new(number) { rand(1..sides) }
            sum = rolls.reduce(:+)

            event.respond("You rolled: #{rolls.join(', ')}. Total: #{sum}.")
        end
    end
end