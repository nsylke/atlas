module Atlas
	class Uptime
		attr_reader :boot

		def initialize
			@boot = Time.now
		end

		def uptime
			dhms.join(', ')
		end

		private

		def dhms
			seconds = (Time.now - @boot).to_i

			days = seconds / 86400
			seconds -= days * 86400
			hours = seconds / 3600
			seconds -= hours * 3600
			minutes = seconds / 60
			seconds -= minutes * 60

			["#{days}d", "#{hours}h", "#{minutes}m", "#{seconds}s"]
		end
	end
end