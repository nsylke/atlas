require 'rest-client'
require 'json'

module Xkcd
	API_BASE = 'http://xkcd.com'.freeze
	FORMAT   = 'info.0.json'.freeze
	EXPLAIN = 'http://www.explainxkcd.com'

	class Comic
		attr_reader :number

		attr_reader :time
		alias published time
		alias date time

		attr_reader :title

		attr_reader :safe_title

		attr_reader :alt
		alias description alt

		attr_reader :xkcd_url
		alias url xkcd_url

		attr_reader :image_url
		alias image image_url

		attr_reader :explain_url
		alias explain explain_url

		attr_reader :transcript
		alias text transcript

		attr_reader :news

		def initialize(data)
			@number = data[:num]
			@time = Time.new data[:year], data[:month], data[:day]
			@title = data[:title]
			@safe_title = data[:safe_title]
			@alt = data[:alt]
			@xkcd_url = "#{API_BASE}/#{data[:num]}"
			@image_url = data[:img]
			@explain_url = "#{EXPLAIN}/#{data[:num]}"
			@transcript = data[:transcript]
		end
	end

	module_function

	def latest
		Comic.new API.latest
	end

	def fetch(number)
		Comic.new API.fetch number
	end

	def random
		Comic.new API.random
	end

	module API
		module_function

		def get(path = '')
			JSON.parse RestClient.get("#{API_BASE}/#{path}"), symbolize_names: true
		end

		def latest
			get FORMAT
		end

		def fetch(number)
			get "#{number}/#{FORMAT}"
		end

		def random
			fetch rand latest[:num]
		end
	end
end