class Category < ActiveRecord::Base
  has_many :videos, -> { order("created_at DESC") }, foreign_key: :category_id

  validates_presence_of :name

  def recent_videos
    self.videos.first(6)
  end
end