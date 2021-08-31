class AddStatusToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :status, :string
  end
end
