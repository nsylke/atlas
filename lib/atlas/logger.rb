module Atlas
	class Logger
		attr_reader :output

		def initialize
			@output = STDOUT
		end

		def info(message, event = nil)
			return log("[INFO : atlas] #{message}") if event.nil?

			log("[INFO : atlas] [#{event}] #{message}")
		end

		def log(messages)
			Array(messages).each do |message|
				@output.puts message
			end
		end
	end
end