class RemoveNameFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :commenter, :string
  end
end
