class Rotate

  def processed(params)
   task = Task.new params
   task.remote_image_url = params['image']
   task.save!

   image = MiniMagick::Image.open(task.image.file.file)
   image.rotate params['params']
   image.format "jpeg"
   image.write task.image.file.file
   task
  end
end
