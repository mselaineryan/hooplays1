class UsersController < ApplicationController
  
  def show 
  	@user = User.find(params[:id])
  	render :layout => 'bootstraplayout.html.erb'
  end

  def new
  	@user = User.new
  	render :layout => 'bootstraplayout.html.erb'
  end

  def create
  	@user = User.new(user_params) #not the final implementation!
  	if @user.save
      log_in @user
  		flash[:success] = "Thanks for joining Hooplays!"
  		redirect_to @user
  	else
		render 'new', :layout => 'bootstraplayout.html.erb'
	end
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

end
