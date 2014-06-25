class StaticPagesController < ApplicationController
  def home
  	render :layout => 'application.html.erb'
  end

  def about_us 
  	render :layout => 'bootstraplayout.html.erb'
  end


end
