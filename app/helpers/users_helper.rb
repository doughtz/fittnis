module UsersHelper
    
      # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
  
  # corrects nil workouts if present
  def correct_workout_nil
    if @user.workouts == nil
      @user.workouts = 0
    end
  end
  
  
  def update_workouts_and_new_workoutpoint
    if logged_in?
        correct_workout_nil
        @user.workouts += 1
        @user.save
        @workoutpoint = @user.workoutpoints.build(workout_point: 1)
        @workoutpoint.save
        render(json: { message: "Workouts increased" }, status: :ok) and return
      else 
        render(json: { message: "Workouts increased" }, status: :ok) and return
    end
  end
  
end
