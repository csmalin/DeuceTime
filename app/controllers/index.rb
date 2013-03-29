before do
#   puts User.find_by_token(session[:token])
# @current_user = User.find_by_token(session[:token])
end


get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/home' do 
  erb :home
end


get '/location/add' do
  erb :add_location
end

post '/location/add' do
  params[:location][:address] = params[:address1] + " " + params[:address2]
  location = Location.create(params[:location])
  redirect "/location/#{location.id}"
end


get '/location/:location_id' do
  @location = Location.find(params[:location_id])
  @bathrooms = @location.bathrooms
  @bathroom_scores = []

  @bathrooms.each do |bathroom|
    score = bathroom.reviews.where('thumb_score = ?', true).count - bathroom.reviews.where('thumb_score = ?', false).count
    @bathroom_scores << [bathroom, score]
  end

  erb :location_reviews
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
  user.login
  session[:token] = user.token
  redirect '/home'
end

get '/review' do
erb :review
end
