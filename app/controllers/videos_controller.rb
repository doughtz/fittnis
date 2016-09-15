class VideosController < ApplicationController
  before_action :admin_user,   only: [:new, :create]
  # Render mobile or desktop depending on User-Agent for these actions.
  before_filter :check_for_mobile, :only => [:new, :edit]
  include VideosHelper
    
  def new
    @video = Video.new
  end
  
  def index
    @videos = Video.paginate(:page => params[:page], :per_page => 10)
  end
  
  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:info] = "Video uploaded."
      redirect_to root_url #check if this doesn't work, change to root_url
    else
      flash[:info] = "Video upload failed."
      render 'new'
    end
  end


# Adds time watched to User Model while watching video

def show
  video = Video.mediakey(Time.now.strftime("%Y%m%d").to_i)
  # Assuming Video belongs_to User, User has two fields called started_watching_at and duration 
  video.user.update_attribute(:started_watching_at, [current_time])
  video.user.update_attribute(:watching_duration, 0)
end

# This method is to update user watching time
def touch_duration
  video = Video.find(params[:id])
  # Calculate time different then convert to duration
  duration = [current_time] - [started_watching_at]
  video.user.update_attribute(:watching_duration, duration)
  respond_to do |format|
    format.js { render nothing: true }
  end
end


  private

    def video_params
      params.require(:video).permit(:user_id, :title, :description, :length,
                                   :tags, :equipment, :videofile, :rating, :categor)
    end  


# Confirms an admin user.
    def admin_user
      if logged_in?
      redirect_to(root_url) unless current_user.admin?
      else
        flash[:danger] = "You reached an invalid url and have been redirected to the home page."
      redirect_to(root_url)
      end
    end
    
    
    
end