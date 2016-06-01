class AddImagemessageuploadToImagemessages < ActiveRecord::Migration
  def change
    add_column :imagemessages, :imagemessageupload, :string
  end
end
