require './lib/hangman.rb'

class HangmanApp < Sinatra::Base
	set :root, File.join(File.dirname(__FILE__), '..')
	set :views, Proc.new { File.join(root, 'views') }
	
	configure :development do
		register Sinatra::Reloader
	end
	
	get '/' do
		@@hangman = Hangman.new
		erb :index, locals: {hangman: @@hangman}
	end
	
	post '/' do
		choice = @@hangman.play(params[:guess])
		
		erb :guess, locals: {guess: choice, hangman: @@hangman}
	end
end