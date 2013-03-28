class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |u|
      u.string :username
      u.string :email
      u.string :password_hash
      u.string :token
      u.timestamps
    end
  end
end
