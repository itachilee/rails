class WelcomeController < ApplicationController
	def index
		flash[:alert] = "it's time to go to bed"
	end
end
