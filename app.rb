require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require_relative './lib/user.rb'

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
    'Book a space'
  end

  get '/sessions/new' do
    erb :log_in
  end

  post '/sessions/new' do
    user = User.authenticate(email: params[:email], password: params[:password])
    if user
      session[:user_id] = user.id
      'Book a space'
    else
      flash[:notice] = "Please check your email or password."
     redirect ('/sessions/new')
   end
    session[:user_id] = user.id
    'Book a space'
  end

  run! if app_file == $0  
end