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
    p params
    'Book a space'
  end

  run! if app_file == $0  
end