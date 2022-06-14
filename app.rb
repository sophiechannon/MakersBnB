require "sinatra/base"
require "sinatra/reloader"

class Makersbnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get "/" do
    "Test"
  end

  get "/spaces" do
    @properties = [
      "Property 1",
      "Property 2",
      "Property 3",
    ]
    erb :'spaces/spaces'
  end

  run! if app_file == $0
end
