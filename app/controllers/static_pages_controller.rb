class StaticPagesController < ApplicationController
  include VideosHelper
  # Render mobile or desktop depending on User-Agent for these actions.
  before_filter :check_for_mobile, :only => [:new, :edit]
  
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
  
  def create
  end
  
  def refresher
    @microposts = current_video.microposts.all
    
    respond_to do |format|
    format.js
    end
  end
end
