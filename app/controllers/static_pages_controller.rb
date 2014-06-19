class StaticPagesController < ApplicationController
  def home
  	render :layout => 'application.html.erb'
  	# missing template layouts/style.css 
  end

  def about_us 
  	render :layout => 'bootstraplayout.html.erb'
  end


end
