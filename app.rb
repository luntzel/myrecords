# Bundler
require "rubygems"
require "bundler/setup"
require 'sinatra'
require 'mongo'
require 'json/ext' # required for .to_json


configure do
  set :logging, true
  db = Mongo::Connection.new.db('myrecords');
end

# The app
class Myrecords < Sinatra::Base
  get "/" do
    "Hello, is it me you're looking for?"
  end

  get '/bands/?' do
    content_type :json
  end

end
