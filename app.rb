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
require_all 'class'
require_all 'model'


Dotenv.load

class App < Sinatra::Application
  register Sinatra::Initializers
  configure do
    set :raise_sinatra_param_exceptions, true
    set show_exceptions: false
    set :public_folder, 'uploads'
  end

post '/load' do
    param :task,      String, in: ['save', 'resize', 'rotate'],  required: true
    param :params,    String, required: true
    param :image,     String, required: true

    task = TaskFactory.getInstance.getObj(params)
    task = task.processed(params)


    json({
              id: task.id.to_s,
              params: task.params.to_s,
              image: task.image.file.file,
          })
end

get '/get_task/:id' do
   param :id, String, required: true
   task = Task.find params['id']

   json({
             id: task.id.to_s,
             params: task.params.to_s,
             link: task.image.url
         })
end


error Sinatra::Param::InvalidParameterError do
    status 422
    json({
             error: "#{env['sinatra.error'].param} is invalid"
         })
  end

  error Mongoid::Errors::DocumentNotFound do
    status 404
    json({
             error: "Task Not Found"
         })
  end

end
