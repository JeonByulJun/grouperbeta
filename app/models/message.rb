class Message < ActiveRecord::Base
  belongs_to :chat
  has_and_belongs_to_many :users
  has_one :imagemessage
  has_one :filemessage
end
