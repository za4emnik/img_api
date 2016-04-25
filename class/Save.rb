class Save

  def processed(params)
    task = Task.new params
    task.remote_image_url = params['image']
    task.save!
  end

end
