module Atlas
	class Stats
		def update
			request('https://discordbots.org/api', "/bots/#{Atlas::BOT.profile.id}/stats", Atlas::CONFIG.tokens['discordbots_org'], Atlas::BOT.servers.count)
			request('https://bots.discord.pw/api', "/bots/#{Atlas::BOT.profile.id}/stats", Atlas::CONFIG.tokens['discord_pw'], Atlas::BOT.servers.count)
		end

		private

		def request(base, path, token, count)		
			body = {}
			body['server_count'] = count

			uri = URI.parse("#{base}#{path}")
			request = Net::HTTP::Post.new(uri)
			request['Authorization'] = token
			request['Content-Type'] = 'application/json'
			request.body = JSON.dump(body)

			req_options = {
				use_ssl: uri.scheme == "https"
			}

			response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
				http.request(request)
			end
		end
	end
end