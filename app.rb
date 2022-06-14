require "sinatra/base"
require "sinatra/reloader"
require "./lib/property"

class Makersbnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get "/" do
    "Test"
  end

  get "/spaces" do
    @properties = Property.all
    erb :'spaces/spaces'
  end

  run! if app_file == $0
end
