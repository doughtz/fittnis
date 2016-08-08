class Video < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 4000 }
  validates :length, presence: true
  validates :tags, presence: true
  validates :equipment, presence: true
  validates :mediakey, presence: true
  validates :rating, presence: true
  validates :categor, presence: true
  validates :calories, presence: true
  validates :workoutseconds, presence: true
  
  $videoarray = self.all.to_a
  
  # return mediakey on today's video
  def self.mediakey(timestamp)
    
    $videoarray.each do |x|
      if x.mediakey.to_i == timestamp
        return x.videofile
      end
    end
    
  end
  
  # return today's calories
  def self.videocalories(timestamp)
    
    $videoarray.each do |x|
      if x.mediakey.to_i == timestamp
        return x.calories
      end
    end
    
  end
  
  # return video's total workoutseconds
  def self.videoseconds(timestamp)
    
    $videoarray.each do |x|
      if x.mediakey.to_i == timestamp
        return x.workoutseconds
      end
    end
    
  end
    
end
