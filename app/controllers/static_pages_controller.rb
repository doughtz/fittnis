class StaticPagesController < ApplicationController
  include VideosHelper
  
  def home
    @microposts = current_video.microposts.all if video_exists
    @micropost = current_user.microposts.build if logged_in?
    @user = current_user if logged_in?
  end

  def about
  end

  def contact
  end

  def help
  end
  
  def create
  end
  
  def refresher
    @microposts = current_video.microposts.all if video_exists
    
    respond_to do |format|
    format.js
    end
  end
end
