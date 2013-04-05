require 'sinatra'

before do 
	@defeat = {rock: :scissors, paper: :rock, scissors: :paper}
	@throws = @defeat.keys
end

get '/' do
	erb :index
end

get '/throw/:type' do
	#declare content type
	content_type :txt
	#use params hash like in rails for form data and query string
	player_throw = params[:type].to_sym

	if !@throws.include?(player_throw)
		halt 403, "You must throw one of the following #{@throws}"
	end

	#select random throw for computer
	computer_throw = @throws.sample

	#work out a winner
	if player_throw == computer_throw
		"You tied, no dice!
		\nF5 to try again with your current throw or back to exit."
	elsif computer_throw == @defeat[player_throw]
		"Nice, #{player_throw} bests #{computer_throw}.
		\nF5 to try again with your current throw or back to exit."
	else
		"You lose, Springfield!
		\nF5 to try again with your current throw or back to exit."
	end
end
