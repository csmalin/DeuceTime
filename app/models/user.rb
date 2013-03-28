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

  def login(params)
    @user = User.find_by_email(params[:email])
    if @user.password == params[:password]
      @user.update_attributes(:token => SecureRandom.uuid)
      @user.save
    end
  end


end
