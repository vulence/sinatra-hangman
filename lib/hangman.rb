class Hangman
	attr_accessor :marked_word, :word, :right_choices, :wrong_choices, :fails, :url
	
	def initialize			
		@fails = 6
		@url = "images/0.jpg"
		@right_choices = ""
		@wrong_choices = ""
		
		random_word
	end
	
	def play(player_guess)
		player_guess = player_guess
		
		if (!player_guess.match(/^[[:alpha:]]+$/) || @right_choices.include?(player_guess) || @wrong_choices.include?(player_guess) || player_guess == "")
			if ((@right_choices.include?(player_guess) || @wrong_choices.include?(player_guess)) && player_guess != "")
				return [@marked_word, "You already guessed that letter"]
			else
				return [@marked_word, "Invalid input"]
			end
		end
			
		if (!check_letters(player_guess))
			wrong_choice(player_guess)
			return [@word, "You ran out of guesses!"] if (lose?)
			return [@marked_word]
		end
			
		right_choice(player_guess)
		replace_letters
			
		win?
	end
	
	def random_word
		dictionary = File.readlines("dictionary/5desk.txt")
		x = rand(0..61000)

		while(dictionary[x].length < 5 || dictionary[x].length > 12)
			x = rand(0..61000)
		end
	
		@word = dictionary[x].chomp.downcase.scan(/./).join(" ")
		@marked_word = @word.gsub(/[a-z]/, "_")
	end

	def check_letters(player_guess)
		player_guess = player_guess
		
		if (!@word.include?(player_guess))
			@fails -= 1
			self.update_url
			return false
		end
		
		return true
	end
	
	def replace_letters
		@marked_word = @word.gsub(/[^#{@right_choices}\s*]/, "_")
	end
	
	def win?
		return [@marked_word, "You win!"] if (@word == @marked_word)
		return [@marked_word]
	end
	
	def lose?
		if (@fails == 0)
			self.update_url
			return true
		end
		
		return false
	end
	
	def wrong_choice(choice)
		if (@wrong_choices != "")
			@wrong_choices += ", " + choice
		else
			@wrong_choices += choice
		end
	end
	
	def right_choice(choice)
		if (@right_choices != "")
			@right_choices += ", " + choice
		else
			@right_choices += choice
		end
	end
	
	def update_url
		case @fails
		when 6
			@url = "images/0.jpg"
		when 5
			@url = "images/1.jpg"
		when 4
			@url = "images/2.jpg"
		when 3
			@url = "images/3.jpg"
		when 2
			@url = "images/4.jpg"
		when 1
			@url = "images/5.jpg"
		when 0
			@url = "images/6.jpg"
		else
			"ERROR"
		end
	end
end