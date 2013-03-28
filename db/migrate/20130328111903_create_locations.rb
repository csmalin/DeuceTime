class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |l|
      l.string :name, :address
      l.float :lat, :lon
      l.timestamps
    end
  end
end
