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
