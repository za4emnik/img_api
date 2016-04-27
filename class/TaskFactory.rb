class TaskFactory #factory class

  #singleton
  @@instance = TaskFactory.new()
  def self.getInstance
   return @@instance
  end
  private_class_method :new

  def getObj (params)
   case params['task']
    when 'save'
     Save.new
    when 'resize'
     Resize.new
    when 'rotate'
     Rotate.new
    else
     puts "unknow task"
    end
  end
end
