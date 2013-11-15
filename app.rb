# Bundler
require "rubygems"
require "bundler/setup"
require 'sinatra'
require 'mongo'

include Mongo

configure do
  set :logging, true
  conn = MongoClient.new("localhost", 27017)
  set :mongo_connection, conn
  set :mongo_db, conn.db('myrecords')
end

# The app
class Myrecords < Sinatra::Base
  get "/" do
    "Hello, is it me you're looking for? YEAH!!!"
  end
  get '/collections/?' do
    settings.mongo_db.collection_names
  end

  # list all documents in the myrecord collection
  get '/documents/?' do
    content_type :json
    settings.mongo_db['myrecords'].find.to_a.to_json
  end

  # find a document by its ID
  get '/document/:id/?' do
    content_type :json
    document_by_id(params[:id]).to_json
  end

  # insert a new document from the request parameters,
  # then return the full document
  post '/new_document/?' do
    content_type :json
    new_id = settings.mongo_db['myrecords'].insert params
    document_by_id(new_id).to_json
  end

end

