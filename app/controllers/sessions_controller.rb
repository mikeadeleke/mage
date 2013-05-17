class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by_username(params[:session][:username].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to home_path
		else
			flash[:error] = "Yikes! Something didn't match up."
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to home_url
	end
end