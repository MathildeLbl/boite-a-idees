class RenameContentToBodyInComments < ActiveRecord::Migration[7.2]
  def change
    rename_column :comments, :content, :body
  end
end
