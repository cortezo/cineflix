class DropUserFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :user, :string
  end
end
