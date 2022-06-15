require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require './lib/property'
require './lib/user.rb'

class Makersbnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  register Sinatra::Flash
  enable :sessions

  get '/' do
    erb :index
  end

  post '/user' do
    user = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect '/spaces'
  end

  get '/sessions/new' do
    erb :log_in
  end

  post '/sessions/new' do
    user = User.authenticate(email: params[:email], password: params[:password])
    if user
      session[:user_id] = user.id
      redirect '/spaces'
    else
      flash[:notice] = "Please check your email or password."
     redirect ('/sessions/new')
   end
    session[:user_id] = user.id
  end

  get '/logout' do
    session[:user_id] = nil
    redirect '/'
  end

  get "/spaces" do
    @properties = Property.all
    erb :'spaces/spaces'
  end

  get "/spaces/new" do
    erb :'/spaces/new'
  end

  post "/spaces/new" do
    Property.create(name: params[:property_name], description: params[:description], price: params[:price].to_i)
    redirect ("/spaces")
  end

  run! if app_file == $0
end
