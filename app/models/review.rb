class Review < ActiveRecord::Base
  belongs_to :user, foreign_key: :user_id
  belongs_to :video, foreign_key: :video_id

  validates_presence_of :rating
  validates_numericality_of :rating, only_integer: true, less_than_or_equal_to: 5, greater_than: 0
  validates :body, length: { maximum: 1000 }
  validates_uniqueness_of :user_id, scope: :video_id
end