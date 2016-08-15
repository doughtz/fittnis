class User < ActiveRecord::Base
  has_many :videos
  has_many :workoutpoints
  has_many :workoutsecs
  has_many :calspersecs
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :username, presence: true, length: { maximum: 50 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
   # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  
  #
  ##
  ###
  ####   WORKOUT STATS
  ###
  ##
  #
  
  #converts seconds into readable formatting
  def workout_time_formatting(seconds)
    minutes = seconds / 60
    hours = seconds / 3600
    remaining_minutes = (minutes*60-hours*3600)/60
    remaining_seconds = seconds - minutes*60
    if hours == 0 && minutes == 0
      return "00:00:#{sprintf '%02i', remaining_seconds}"
     elsif hours == 0 && minutes > 0
       return "00:#{sprintf '%02i', minutes}:#{sprintf '%02i', remaining_seconds}"
     else
       return "#{sprintf '%02i', hours}:#{sprintf '%02i', remaining_minutes}:#{sprintf '%02i', remaining_seconds}"
    end
  end
  
  ###### OVERALL
  ###### OVERALL
  
  # returns total workoutseconds
  def overall_workoutseconds
    return workout_time_formatting(self.workoutsecs.all.count)
  end
  
  # returns total workout calories
  def overall_calspersec
    total = 0
    self.calspersecs.all.each do |x|
      total += x.calories_persec
    end
    return total
  end
  
  ###### THIS MONTH
  ###### THIS MONTH
  
  # returns number of workouts for current month
  def current_month_workoutpoints
    total = 0
    self.workoutpoints.each do |x|
      if x.created_at.strftime("%Y%m").to_i == Time.now.strftime("%Y%m").to_i
        total += 1
      end
    end
    return total
  end
  
  # returns number of workout calories for current month
  def current_month_calspersec
    total = 0.0
    self.calspersecs.each do |x|
      if x.created_at.strftime("%Y%m").to_i == Time.now.strftime("%Y%m").to_i
        total += x.calories_persec
      end
    end
    return total.to_i
  end
  
  # returns number of workout seconds for current month
  def current_month_workoutsecs
    seconds = 0
    self.workoutsecs.each do |x|
      if x.created_at.strftime("%Y%m").to_i == Time.now.strftime("%Y%m").to_i
        seconds += 1
      end
    end
    workout_time_formatting(seconds)
  end
  
  ###### LAST MONTH
  ###### LAST MONTH
  
  # returns number of workouts for last month
  def last_month_workoutpoints
    total = 0
    self.workoutpoints.each do |x|
      if x.created_at.strftime("%Y%m").to_i == (Time.now - 1.month).strftime("%Y%m").to_i
        total += 1
      end
    end
    return total
  end
  
  # returns number of workout calories for last month
  def last_month_calspersec
    total = 0.0
    self.calspersecs.each do |x|
      if x.created_at.strftime("%Y%m").to_i == (Time.now - 1.month).strftime("%Y%m").to_i
        total += x.calories_persec
      end
    end
    return total.to_i
  end
  
  # returns number of workout seconds for last month
  def last_month_workoutsecs
    seconds = 0
    self.workoutsecs.each do |x|
      if x.created_at.strftime("%Y%m").to_i == (Time.now - 1.month).strftime("%Y%m").to_i
        seconds += 1
      end
    end
    workout_time_formatting(seconds)
  end
  
  ###### THIS WEEK
  ###### THIS WEEK
  
  
  # returns # of workouts for this week
  def workouts_for_this_week
    total_week_workoutpoints = 0
    today_date = Time.now
    todays_day_number = Time.now.strftime("%w").to_i # ---> 0 is Sunday, 1 is Monday, etc.
    days_of_week = {sunday: today_date, monday: today_date, tuesday: today_date, wednesday: today_date, thursday: today_date, friday: today_date, saturday: today_date}
    increment = todays_day_number*-1
    this_week = Hash.new
    days_of_week.each do |key, value|
      value += increment.days
      this_week[key] = value
      increment += 1
    end
    week_dates = this_week.values
    week_dates_in_numbers = []
    week_dates.each do |x|
      week_dates_in_numbers << x.strftime("%Y%m%d").to_i
    end
    self.workoutpoints.each do |x|
      if week_dates_in_numbers.include?(x.created_at.strftime("%Y%m%d").to_i)
        total_week_workoutpoints += 1
      end
    end
    return total_week_workoutpoints  
  end
  
  # returns workout calories for this week
  def calories_for_this_week
    total_week_calories = 0.0
    today_date = Time.now
    todays_day_number = Time.now.strftime("%w").to_i # ---> 0 is Sunday, 1 is Monday, etc.
    days_of_week = {sunday: today_date, monday: today_date, tuesday: today_date, wednesday: today_date, thursday: today_date, friday: today_date, saturday: today_date}
    increment = todays_day_number*-1
    this_week = Hash.new
    days_of_week.each do |key, value|
      value += increment.days
      this_week[key] = value
      increment += 1
    end
    week_dates = this_week.values
    week_dates_in_numbers = []
    week_dates.each do |x|
      week_dates_in_numbers << x.strftime("%Y%m%d").to_i
    end
    self.calspersecs.each do |x|
      if week_dates_in_numbers.include?(x.created_at.strftime("%Y%m%d").to_i)
        total_week_calories += x.calories_persec
      end
    end
    return total_week_calories.to_i
  end
  
  # returns workoutseconds for this week
  def workoutseconds_for_this_week
    total_week_workoutseconds = 0
    today_date = Time.now
    todays_day_number = Time.now.strftime("%w").to_i # ---> 0 is Sunday, 1 is Monday, etc.
    days_of_week = {sunday: today_date, monday: today_date, tuesday: today_date, wednesday: today_date, thursday: today_date, friday: today_date, saturday: today_date}
    increment = todays_day_number*-1
    this_week = Hash.new
    days_of_week.each do |key, value|
      value += increment.days
      this_week[key] = value
      increment += 1
    end
    week_dates = this_week.values
    week_dates_in_numbers = []
    week_dates.each do |x|
      week_dates_in_numbers << x.strftime("%Y%m%d").to_i
    end
    self.calspersecs.each do |x|
      if week_dates_in_numbers.include?(x.created_at.strftime("%Y%m%d").to_i)
        total_week_workoutseconds += 1
      end
    end
    return workout_time_formatting(total_week_workoutseconds)  
  end
  
  ###### LAST WEEK
  ###### LAST WEEK
  
  # returns workout points for LAST week
  def workouts_for_last_week
    total_week_workoutpoints = 0
    today_date = Time.now
    todays_day_number = Time.now.strftime("%w").to_i # ---> 0 is Sunday, 1 is Monday, etc.
    days_of_week = {sunday: today_date, monday: today_date, tuesday: today_date, wednesday: today_date, thursday: today_date, friday: today_date, saturday: today_date}
    increment = (todays_day_number*-1) - 7
    last_week = Hash.new
    days_of_week.each do |key, value|
      value += increment.days
      last_week[key] = value
      increment += 1
    end
    week_dates = last_week.values
    week_dates_in_numbers = []
    week_dates.each do |x|
      week_dates_in_numbers << x.strftime("%Y%m%d").to_i
    end
    self.workoutpoints.each do |x|
      if week_dates_in_numbers.include?(x.created_at.strftime("%Y%m%d").to_i)
        total_week_workoutpoints += 1
      end
    end
    return total_week_workoutpoints  
  end
  
  # returns workout calories for last week
  def calories_for_last_week
    total_week_calories = 0
    today_date = Time.now
    todays_day_number = Time.now.strftime("%w").to_i # ---> 0 is Sunday, 1 is Monday, etc.
    days_of_week = {sunday: today_date, monday: today_date, tuesday: today_date, wednesday: today_date, thursday: today_date, friday: today_date, saturday: today_date}
    increment = (todays_day_number*-1) - 7
    last_week = Hash.new
    days_of_week.each do |key, value|
      value += increment.days
      last_week[key] = value
      increment += 1
    end
    week_dates = last_week.values
    week_dates_in_numbers = []
    week_dates.each do |x|
      week_dates_in_numbers << x.strftime("%Y%m%d").to_i
    end
    self.calspersecs.each do |x|
      if week_dates_in_numbers.include?(x.created_at.strftime("%Y%m%d").to_i)
        total_week_calories += x.calories_persec
      end
    end
    return total_week_calories.to_i
  end
  
  # returns workout seconds for LAST week
  def workoutseconds_for_last_week
    total_week_workoutseconds = 0
    today_date = Time.now
    todays_day_number = Time.now.strftime("%w").to_i # ---> 0 is Sunday, 1 is Monday, etc.
    days_of_week = {sunday: today_date, monday: today_date, tuesday: today_date, wednesday: today_date, thursday: today_date, friday: today_date, saturday: today_date}
    increment = (todays_day_number*-1) - 7
    last_week = Hash.new
    days_of_week.each do |key, value|
      value += increment.days
      last_week[key] = value
      increment += 1
    end
    week_dates = last_week.values
    week_dates_in_numbers = []
    week_dates.each do |x|
      week_dates_in_numbers << x.strftime("%Y%m%d").to_i
    end
    self.workoutsecs.each do |x|
      if week_dates_in_numbers.include?(x.created_at.strftime("%Y%m%d").to_i)
        total_week_workoutseconds += 1
      end
    end
    return workout_time_formatting(total_week_workoutseconds)
  end
  
  ###### TODAY & 
  ###### YESTERDAY STATS
  
  # returns number of workouts for today
  def today_workoutpoints
    total = 0
    self.workoutpoints.each do |x|
      if x.created_at.strftime("%Y%m%d").to_i == Time.now.strftime("%Y%m%d").to_i
        total += 1
      end
    end
    return total
  end
  
  # returns number of workout calories for today
  def today_calspersec
    total = 0.0
    self.calspersecs.each do |x|
      if x.created_at.strftime("%Y%m%d").to_i == Time.now.strftime("%Y%m%d").to_i
        total += x.calories_persec
      end
    end
    return total.to_i
  end
  
  # returns number of workout seconds for today
  def today_workoutsecs
    seconds = 0
    self.workoutsecs.each do |x|
      if x.created_at.strftime("%Y%m%d").to_i == Time.now.strftime("%Y%m%d").to_i
        seconds += 1
      end
    end
    workout_time_formatting(seconds)
  end
  
  # returns number of workouts for yesterday
  def yesterday_workoutpoints
    total = 0
    self.workoutpoints.each do |x|
      if x.created_at.strftime("%Y%m%d").to_i == (Time.now-1.day).strftime("%Y%m%d").to_i
        total += 1
      end
    end
    return total
  end
  
  # returns number of workout calories for yesterday
  def yesterday_calspersec
    total = 0.0
    self.calspersecs.each do |x|
      if x.created_at.strftime("%Y%m%d").to_i == (Time.now-1.day).strftime("%Y%m%d").to_i
        total += x.calories_persec
      end
    end
    return total.to_i
  end
  
  # returns number of workout seconds for yesterday
  def yesterday_workoutsecs
    seconds = 0
    self.workoutsecs.each do |x|
      if x.created_at.strftime("%Y%m%d").to_i == (Time.now-1.day).strftime("%Y%m%d").to_i
        seconds += 1
      end
    end
    workout_time_formatting(seconds)
  end
  
  
  
  private

  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end

  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
  
  
    
end