require 'sinatra'
require 'sinatra/base'
require 'sinatra/param'
require 'sinatra/json'
require 'sinatra-initializers'
require 'shotgun'
require 'mongoid'
require 'dotenv'
require 'mini_magick'
require 'carrierwave'
require 'carrierwave/mongoid'
require 'require_all'
require 'active_model_serializers'
require_all 'class'
require_all 'model'
require_all 'serializers'
require_all 'inc'

Dotenv.load

class App < Sinatra::Application
  register Sinatra::Initializers
  configure do
    set :raise_sinatra_param_exceptions, true
    set show_exceptions: false
    set :public_folder, 'uploads'
  end

post '/load' do
  #params
  param :task,      String, in: ['save', 'resize', 'rotate'],  required: true
  param :params,    String, required: true
  param :image,     String, required: true

  #processed task
  task = TaskFactory.getInstance.getObj(params)
  task = task.processed(params)

  #output
  json task
end

get '/get_task/:id' do
  #params
  param :id, String, required: true

  #find task
  task = Task.find params['id']

  #output
  json task
end

end
