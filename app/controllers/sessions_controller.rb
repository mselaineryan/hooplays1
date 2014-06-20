class SessionsController < ApplicationController

	def new
		render :layout => 'bootstraplayout.html.erb'
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
    	if user && user.authenticate(params[:session][:password])
    		log_in user # need to write the log_in method
    		redirect_to user
      		
    	else
      		flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      		render 'new', :layout => 'bootstraplayout.html.erb'
    	end
	end

	def destroy
		log_out
		redirect_to root_url
	end
end
