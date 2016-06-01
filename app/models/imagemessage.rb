class Imagemessage < ActiveRecord::Base
  mount_uploader :imagemessageupload, ImagemessageuploadUploader
  belongs_to :message
  belongs_to :chat
end
