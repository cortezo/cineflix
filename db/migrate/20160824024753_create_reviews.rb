class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.string :user
      t.string :body
      t.timestamps
    end
  end
end
