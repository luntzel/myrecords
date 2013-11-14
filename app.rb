# Bundler
require "rubygems"
require "bundler/setup"
require 'sinatra'
require 'mongo'
require 'json/ext' # required for .to_json

include Mongo

configure do
  conn = MongoClient.new("localhost", 27017)
  set :mongo_connection, conn
  set :mongo_db, conn.db('myrecords')
en

# The app
class Testing < Sinatra::Base
  get "/" do
    "Hello, Fuckbag YEAH!!!!"
  end
end
