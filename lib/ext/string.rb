class String
	attr_reader :emoji, :nato

	def pluralize(count, value = nil)
		value = 's' if value.nil?

		word = if (count == 1)
			self
		else
			"#{self}#{value}"
		end

		"#{count} #{word}"
	end

	def to_emojis
		emoji_alphabet.tap do |parts|
			@emoji = parts.join(' ')
		end

		@emoji
	end

	def to_nato
		nato_alphabet.tap do |parts|
			@nato = parts.join(' ')
		end

		@nato
	end

	protected

	def emoji_alphabet
		alphabet = {
			:a => :':regional_indicator_a:',
	        :b => :':regional_indicator_b:',
	        :c => :':regional_indicator_c:',
	        :d => :':regional_indicator_d:',
	        :e => :':regional_indicator_e:',
	        :f => :':regional_indicator_f:',
	        :g => :':regional_indicator_g:',
	        :h => :':regional_indicator_h:',
	        :i => :':regional_indicator_i:',
	        :j => :':regional_indicator_j:',
	        :k => :':regional_indicator_k:',
	        :l => :':regional_indicator_l:',
	        :m => :':regional_indicator_m:',
	        :n => :':regional_indicator_n:',
	        :o => :':regional_indicator_o:',
	        :p => :':regional_indicator_p:',
	        :q => :':regional_indicator_q:',
	        :r => :':regional_indicator_r:',
	        :s => :':regional_indicator_s:',
	        :t => :':regional_indicator_t:',
	        :u => :':regional_indicator_u:',
	        :v => :':regional_indicator_v:',
	        :w => :':regional_indicator_w:',
	        :x => :':regional_indicator_x:',
	        :y => :':regional_indicator_y:',
	        :z => :':regional_indicator_z:',
            :'0' => :':zero:',
            :'1' => :':one:',
            :'2' => :':two:',
            :'3' => :':three:',
            :'4' => :':four:',
            :'5' => :':five:',
            :'6' => :':six:',
            :'7' => :':seven:',
            :'8' => :':eight:',
            :'9' => :':nine:',
            :'!' => :':grey_exclamation:',
            :'?' => :':grey_question:',
            :'#' => :':hash:',
			:'*' => :':asterisk:',
			:' ' => :'   '
		}

		self.split('').map do |parts|
			alphabet[parts.downcase.to_sym]
		end
	end

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
	        :x => :'X-ray',
	        :y => :Yankee,
	        :z => :Zulu,
	        :'1' => :One,
	        :'2' => :Two,
	        :'3' => :Three,
	        :'4' => :Four,
	        :'5' => :Five,
	        :'6' => :Six,
	        :'7' => :Seven,
	        :'8' => :Eight,
	        :'9' => :Nine,
	        :'0' => :Zero,
	        :' ' => :''
		}

		self.split('').map do |parts|
			alphabet[parts.downcase.to_sym]
		end
	end
end