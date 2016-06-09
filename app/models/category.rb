class Category < ActiveRecord::Base
  has_many :videos, -> { order(:title) }, foreign_key: :category_id

  validates_presence_of :name
end