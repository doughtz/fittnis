module VideosHelper
    
# Returns the current logged-in user (if any).
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  #return today's video
  def current_video
    if logged_in? && current_user.time_zone != nil
      the_video = Video.find_by(mediakey: Time.now.in_time_zone(current_user.time_zone).strftime("%Y%m%d").to_i)
    else
      the_video = Video.find_by(mediakey: Time.now.in_time_zone("Pacific Time (US & Canada)").strftime("%Y%m%d").to_i)
    end
    @current_video = the_video
  end
  
  def video_exists
    current_video
    defined_video = defined? @current_video
    if defined_video.nil? || @current_video.nil?
      return false
    else
      return true
    end
  end
  
end
