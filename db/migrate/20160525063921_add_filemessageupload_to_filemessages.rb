class AddFilemessageuploadToFilemessages < ActiveRecord::Migration
  def change
    add_column :filemessages, :filemessageupload, :string

  end
end
