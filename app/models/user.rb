class User < ActiveRecord::Base
  has_many :reviews, -> { order("created_at DESC") }, foreign_key: :user_id
  has_many :queue_items, foreign_key: :user_id

  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email

  has_secure_password
end