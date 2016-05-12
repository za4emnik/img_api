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
require 'sidekiq'
require 'sidekiq/api'
require 'sidekiq/web'
require_all 'class'
require_all 'model'
require_all 'serializers'
require_all 'inc'
require_all 'lib/workers'

Dotenv.load

class App < Sinatra::Application
  register Sinatra::Initializers
  configure do
    set :raise_sinatra_param_exceptions, true
    set show_exceptions: false
    set :public_folder, 'uploads'
  end

  get '/' do
    stats = Sidekiq::Stats.new
		workers = Sidekiq::Workers.new
		"
		<p>Processed: #{stats.processed}</p>
		<p>In Progress: #{workers.size}</p>
		<p>Enqueued: #{stats.enqueued}</p>
		<p><a href='/'>Refresh</a></p>
		<p><a href='/sidekiq'>Dashboard</a></p>
		"
  end

post '/load' do
  #params
  param :task,      String, in: ['save', 'resize', 'rotate'],  required: true
  param :params,    String, required: true
  param :image,     String, required: true

  ImgWorker.perform_async(params)
  #json task
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
