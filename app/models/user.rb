class User < ActiveRecord::Base
  include BCrypt  
  has_many :reviews

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
    @user = User.find_by_email(email)
    return @user if (@user.password == password) 
    nil
  end

  def login
    self.update_attributes(:token => SecureRandom.uuid)
  end

end
