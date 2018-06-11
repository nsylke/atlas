class String
	attr_reader :nato

	def pluralize(count, value = nil)
		value = 's' if value.nil?

		word = if (count == 1)
			self
		else
			"#{self}#{value}"
		end

		"#{count} #{word}"
	end

	def to_nato
		nato_alphabet.tap do |parts|
			@nato = parts.join(' ')
		end

		@nato
	end

	protected

	def nato_alphabet
		alphabet = {
			:a => :Alfa,
	        :b => :Bravo,
	        :c => :Charlie,
	        :d => :Delta,
	        :e => :Echo,
	        :f => :Foxtrot,
	        :g => :Golf,
	        :h => :Hotel,
	        :i => :India,
	        :j => :Juliett,
	        :k => :Kilo,
	        :l => :Lima,
	        :m => :Mike,
	        :n => :November,
	        :o => :Oscar,
	        :p => :Papa,
	        :q => :Quebec,
	        :r => :Romeo,
	        :s => :Sierra,
	        :t => :Tango,
	        :u => :Uniform,
	        :v => :Victor,
	        :w => :Whiskey,
	        :x => :"X-ray",
	        :y => :Yankee,
	        :z => :Zulu,
	        :"1" => :One,
	        :"2" => :Two,
	        :"3" => :Three,
	        :"4" => :Four,
	        :"5" => :Five,
	        :"6" => :Six,
	        :"7" => :Seven,
	        :"8" => :Eight,
	        :"9" => :Nine,
	        :"0" => :Zero,
	        :" " => :""
		}

		self.split('').map do |parts|
			alphabet.fetch parts.downcase.to_sym
		end
	end
end