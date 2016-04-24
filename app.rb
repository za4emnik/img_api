require 'sinatra'
require 'sinatra/base'
require 'sinatra/param'
require 'sinatra/json'
require 'sinatra-initializers'
require 'shotgun'
require 'mongoid'
require 'dotenv'

require 'require_all'
require_all 'class'
require_all 'model'


Dotenv.load

class App < Sinatra::Application

get '/s' do
  "HELLO"
end

end
