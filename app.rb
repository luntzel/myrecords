# Bundler
require "rubygems"
require "bundler/setup"

# Sinatra
require "sinatra"

# The app
class Testing < Sinatra::Base
  get "/" do
    "Hello, Fuckbag!"
  end
end
