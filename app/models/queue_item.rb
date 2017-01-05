class QueueItem < ActiveRecord::Base
  belongs_to :user, foreign_key: :user_id
  belongs_to :video, foreign_key: :video_id

  validates_uniqueness_of :video, scope: :user
  validates_uniqueness_of :position, scope: :user
end