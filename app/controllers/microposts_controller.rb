class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  # Render mobile or desktop depending on User-Agent for these actions.
  before_filter :check_for_mobile, :only => [:new, :edit]
  include VideosHelper

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.video_id = current_video.id
    respond_to do |format|
  if @micropost.save
    format.html { redirect_to(@user) }
    format.xml { render :xml => @user, :status => :created, :location => @user }
    format.js
  else
    format.html { redirect_to(@user) }
    format.xml { render :xml => @micropost.errors }
    format.js { render :json => @micropost.errors }
  end
end
  end
  
  def refresher
    @currentvideo = current_video
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.video_id = current_video.id
  end

  def destroy
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :video_id)
    end
  
end
