class Video < ActiveRecord::Base
  belongs_to :category, foreign_key: :category_id
  has_many :reviews, -> { order("created_at DESC") }, foreign_key: :video_id

  validates_presence_of :title, :description

  def self.search_by_title(search_term="")
    if search_term == ""
      []
    else
      where("title LIKE ?", "%#{search_term}%").order("created_at ASC")
    end
  end
end