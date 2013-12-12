# Bundler
require "rubygems"
require "bundler/setup"
require 'sinatra'
require 'mongo'
require 'mongo_mapper'
require 'mustache/sinatra'

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

register Mustache::Sinatra
require './views/layout'

set :mustache, { :views => './views/', :templates => './templates/' }

  get "/" do
     # Post.create(:title => 'Trust the Stache', :body => '<p>Mustache is a great template language for the client and server') 
    @posts = Post.all 
    mustache :index
  end

  get '/new' do
    @post = Post.new
    mustache :new
  end

  post '/' do
    @post = Post.new(params[:post])
    redirect '/'
  end

  get '/:id' do |id|
    @post = Post.find(id)
    mustache :show
  end

end

class Post
  include MongoMapper::Document

  key :title, String
  key :body, String

  timestamps!
end

