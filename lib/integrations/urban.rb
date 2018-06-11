require 'rest-client'
require 'json'

module UrbanDictionary
	class Definition
		attr_reader :definition
		alias text definition

		attr_reader :word

		attr_reader :thumbs_up

		attr_reader :thumbs_down

		attr_reader :author

		attr_reader :defid
		alias id defid

		attr_reader :permalink
		alias url permalink

		attr_reader :example

		def initialize(data)
			@definition = data[:definition]
			@word = data[:word]
			@thumbs_up = data[:thumbs_up]
			@thumbs_down = data[:thumbs_down]
			@author = data[:author]
			@defid = data[:defid]
			@permalink = data[:permalink]
			@example = data[:example]
		end

		def long?
			[text.length, example.length].any? { |e| e > 1024 }
		end
	end

	module_function

	def define(term)
		response = API.define(term)
		response[:list].map { |d| Definition.new d }
	end

	def random
	    response = API.random
	    response[:list].map { |d| Definition.new d }
	end

	  module API
	    API_BASE = 'http://api.urbandictionary.com'
	    API_VERSION = 'v0'

	    module_function

	    def get(path = '', params = {})
	      response = RestClient.get "#{API_BASE}/#{API_VERSION}/#{path}", params: params
	      JSON.parse response, symbolize_names: true
	    end

	    def define(term)
	      get 'define', { term: term }
	    end

	    def random
	      get 'random'
	    end
	end
end