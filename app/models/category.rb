class Category < ActiveRecord::Base
  has_many :videos, foreign_key: :category_id
end