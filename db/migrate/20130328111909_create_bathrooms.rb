class CreateBathrooms < ActiveRecord::Migration
  def change
    create_table :bathrooms do |b|
    b.string :type
    b.string :specific_location
    b.references :location
    b.timestamps
    end
  end
end
