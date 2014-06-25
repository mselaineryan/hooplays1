class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  # if they're not logged in and they try to hit edit,update or destroy, they get redirected
  before_action :correct_user, only: [:edit, :update]
  # if they're not the correct user and the try to hit edit or update, they get redirected
  before_action :admin_user, only: [:index, :destroy]
  # if they're not the admin user and they try to hit index or destroy they get redirected
  
  def show 
  	@user = User.find(params[:id]) # redirect to @user goes to show because of a rails convention
  	render :layout => 'bootstraplayout.html.erb' # just until I get the regular layout made
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
  		redirect_to @user # show.html.erb
  	else
		render 'new', :layout => 'bootstraplayout.html.erb'
	  end
  end

  def edit
    # automatically shows the edit view without me writing anything
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
    # - no rush because it is exclusively an admin function
    render :layout => 'bootstraplayout.html.erb'
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url # this is index.html.erb but comes up as /users because you put
    # resources :users in your routes.rb file. See http://guides.rubyonrails.org/routing.html
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
