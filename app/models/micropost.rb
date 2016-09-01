class Micropost < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  default_scope -> { order(created_at: :asc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
