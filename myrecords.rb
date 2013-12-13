# Bundler
require "rubygems"
require "bundler/setup"
require 'sinatra'
require 'mongo'
require 'mongo_mapper'
require 'haml'

include Mongo

configure do
  set :logging, true
  conn = MongoClient.new("localhost", 27017)
  set :mongo_connection, conn
  set :mongo_db, conn.db('myrecords')
end


MongoMapper.database = 'myrecords'

# The app
class Myrecords < Sinatra::Base

  get "/" do
    "Hi there. Lets get started!"
  end

  get "/records" do
    haml :records
  end

  get '/new' do
    "this will be the new record page"
  end

  post '/' do
    redirect '/'
  end
p

end

