class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |r|
      r.boolean :thumb_score
      r.string :text
      r.references :bathroom, :user
      r.timestamps
    end
  end
end
