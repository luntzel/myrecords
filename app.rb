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
  set :logging, true
end

# The app
class Testing < Sinatra::Base
  get "/" do
    "Hello, Fuckbag YEAH!!!!"
  end
  get '/collections/?' do
    settings.mongo_db.collection_names
  end

  helpers do
    # a helper method to turn a string ID
    # representation into a BSON::ObjectId
    def object_id val
      BSON::ObjectId.from_string(val)
    end

    def document_by_id id
      id = object_id(id) if String === id
      settings.mongo_db['myrecords'].
        find_one(:_id => id).to_json
    end
  end

  # list all documents in the myrecords collection
  get '/documents/?' do
    content_type :json
    settings.mongo_db['myrecords'].find.to_a.to_json
  end

  # find a document by its ID
  get '/document/:id/?' do
    content_type :json
    document_by_id(params[:id]).to_json
  end

end
