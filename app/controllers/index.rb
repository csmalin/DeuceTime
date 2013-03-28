before do
@current_user = User.find_by_token(session[:token])
end


get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/home' do 
  erb :home
end


post '/login' do
  @user = User.authenticate(params[:email].downcase, params[:password])
  if @user
    @user.login
    session[:token] = @user.token
    redirect '/home'
  else
    redirect '/'
  end
end


post '/signup' do 
  user = User.create(params)
  redirect '/'
end
