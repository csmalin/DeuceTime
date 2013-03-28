get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/login' do
  @user = User.authenticate(params[:email].downcase, params[:password])
  if @user
    redirect '/home'
  else
    redirect '/'
  end
end


post '/signup' do 
  user = User.create(params)
  redirect '/'
end
