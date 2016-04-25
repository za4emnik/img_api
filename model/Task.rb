class Task                  #class for database
  include Mongoid::Document

  field :task,        type: String
  field :params,      type: String
  field :link,        type: String

   mount_uploader :image, ImageUploader
end
