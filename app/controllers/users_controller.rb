class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:index, :destroy]
  
  def show 
  	@user = User.find(params[:id]) # redirect to @user seems to go here
  	render :layout => 'bootstraplayout.html.erb'
  end

  def new
  	@user = User.new
  	render :layout => 'bootstraplayout.html.erb'
  end

  def create
  	@user = User.new(user_params) 
  	if @user.save
      log_in @user
  		flash[:success] = "Thanks for joining Hooplays!"
  		redirect_to @user
  	else
		render 'new', :layout => 'bootstraplayout.html.erb'
	  end
  end

  def edit
    render :layout => 'bootstraplayout.html.erb'
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit', :layout => 'bootstraplayout.html.erb'
    end
  end

  def index
    @users = User.paginate(page: params[:page]) #instead of User.all - need to test 
    #that this works (with a factory? See Hartl Ch.9)
    # - no rush because it is exclusively and admin function
    render :layout => 'bootstraplayout.html.erb'
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

    def logged_in_user
      redirect_to login_url, notice: "Please log in." unless logged_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
