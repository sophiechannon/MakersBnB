require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/user.rb'

class Makersbnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get '/' do
    erb :index
  end

  post '/user' do
    user = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password])
    session[:user_id] = user.id
    'Book a space'
  end

  run! if app_file == $0  
end