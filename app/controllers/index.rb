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

get '/locate' do
  @locations = Location.all
  erb :locations
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

get '/bathroom/:bathroom_id/upvote' do
  bathroom = Bathroom.find(params[:bathroom_id])
  bathroom_location_id = Location.find(bathroom.location_id).id

  unless @current_user.reviews.select {|review| review.bathroom_id == params[:bathroom_id]} 
    review = Review.create(:thumb_score => true)
    @current_user.reviews << review
    bathroom.reviews << review
  end

  redirect "/location/#{bathroom_location_id}"
end

get '/bathroom/:bathroom_id/downvote' do
  bathroom = Bathroom.find(params[:bathroom_id])
  bathroom_location_id = Location.find(bathroom.location_id).id

  unless @current_user.reviews.select {|review| review.bathroom_id == params[:bathroom_id]} 
    bathroom = Bathroom.find(params[:bathroom_id])
    bathroom_location = Location.find(bathroom.location_id)
    bathroom.reviews << Review.create(:thumb_score => false)
  end

  redirect "/location/#{bathroom_location_id}"
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

get '/logout' do
  session.destroy
  redirect '/'
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
