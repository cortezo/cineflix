class Review < ActiveRecord::Base
  belongs_to :user, foreign_key: :user_id
  belongs_to :video, foreign_key: :video_id

  validates_presence_of :body, :rating
  validates_numericality_of :rating, only_integer: true, less_than_or_equal_to: 5, greater_than: 0
  validates :body, length: { maximum: 750 }
end