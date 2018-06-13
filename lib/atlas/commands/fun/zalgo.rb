module Atlas::Commands
	module Zalgo
		extend Discordrb::Commands::CommandContainer

		command(:zalgo) do |event, *args|
			if args[0].nil?
                event.respond('No arguments specified.')
                break
            end

			args = args.join(' ')

			event.respond translate(args)
		end

		module_function

		module Characters
			def self.up
				%w{
					̍ ̎ ̄ ̅
					̿ ̑ ̆ ̐
					͒ ͗ ͑ ̇
					̈ ̊ ͂ ̓
					̈ ͊ ͋ ͌
					̃ ̂ ̌ ͐
					̀ ́ ̋ ̏
					̒ ̓ ̔ ̽
					̉ ͣ ͤ ͥ
					ͦ ͧ ͨ ͩ
					ͪ ͫ ͬ ͭ
					ͮ ͯ ̾ ͛
					͆  ̚
				}
			end

			def self.down
				%w{
					̖ ̗ ̘ ̙
					̜ ̝ ̞ ̟
					̠ ̤ ̥ ̦
					̩ ̪ ̫ ̬
					̭ ̮ ̯ ̰
					̱ ̲ ̳ ̹
					̺ ̻ ̼ ͅ
					͇ ͈ ͉ ͍
					͎ ͓ ͔ ͕
					͖ ͙ ͚ ̣
				}
			end

			def self.mid
				%w{
					̕ ̛  ̀ ́
					͘ ̡  ̢ ̧
					̨ ̴  ̵ ̶
					͏ ͜  ͝ ͞
					͟ ͠  ͢ ̸
					̷ ͡ ҉_
				}
			end

			def self.all ; up + down + mid ; end

			def self.is_char?(char)
				all.find { |c| c == char }
			end
		end

		def translate(text, options = {})
		    result = ''
		    options = { :up => true, :mid => true, :down => true }.merge options

		    text.each_char.each do |char|
		      next if Characters.is_char? char

		      result << char
		      counts = { :up => 0, :mid => 0, :down => 0 }

		      case options[:size]
		      when :mini
		        counts[:up] = rand(8)
		        counts[:mid] = rand(2)
		        counts[:down] = rand(8)
		      when :maxi
		        counts[:up] = rand(16) + 3
		        counts[:mid] = rand(4) + 1
		        counts[:down] = rand(64) + 3
		      else
		        counts[:up] = rand(8) + 1
		        counts[:mid] = rand(6) / 2
		        counts[:down] = rand(8) + 1
		      end

		      [:up, :mid, :down].each do |d|
		        counts[d].times { result << Characters.send(d)[rand Characters.send(d).size] } if options[d]
		      end
		    end

		    result
		end
	end
end