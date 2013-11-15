# Bundler
require "rubygems"
require "bundler/setup"
require 'sinatra'
require 'mongo'


configure do
  set :logging, true
end

# The app
class Myrecords < Sinatra::Base
  get "/" do
    "Hello, is it me you're looking for?"
  end
end
