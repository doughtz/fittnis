class StaticPagesController < ApplicationController
  include VideosHelper
  
  def home
    @microposts = current_video.microposts.all
    @micropost = current_user.microposts.build if logged_in?
    @user = current_user if logged_in?
  end

  def about
  end

  def contact
  end

  def help
  end
end
