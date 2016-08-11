module UsersHelper
    
      # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
  
  # correct nil calories if present
  def correct_calories_nil
    if @user.calories == nil
      @user.calories = 0
    end
  end
  
  # correct nil workoutseconds if present
  def correct_workoutseconds_nil
    if @user.workoutseconds == nil
      @user.workoutseconds = 0
    end
  end
  
  # corrects nil workouts if present
  def correct_workout_nil
    if @user.workouts == nil
      @user.workouts = 0
    end
  end
  
  
  # adds 1 to User.workouts and creates new Workoutpoint object to current_user
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
  
  # creates new Workoutsec object to current_user
  def add_workoutsec
    if logged_in?
      correct_workoutseconds_nil
      @workoutsec = @user.workoutsecs.build(workout_secs: 1)
      @workoutsec.save
      else 
        render(json: { message: "Workouts increased" }, status: :ok) and return
    end
  end
  
end
