class StaticPagesController < ApplicationController
  include VideosHelper
  
  def home
    @microposts = current_video.microposts.all unless current_video.nil?
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
    @microposts = current_video.microposts.all unless current_video.nil?
    
    respond_to do |format|
    format.js
    end
  end
end
