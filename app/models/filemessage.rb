class Filemessage < ActiveRecord::Base
  mount_uploader :filemessageupload, FilemessageuploadUploader
  belongs_to :chat
  belongs_to :message

end
