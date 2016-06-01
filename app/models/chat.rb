class Chat < ActiveRecord::Base
  has_many :messages
  belongs_to :team
  has_and_belongs_to_many :users
  has_one :whiteboard
  has_many :filemessages
  has_many :imagemessages
end
