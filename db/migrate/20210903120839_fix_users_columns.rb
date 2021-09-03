class FixUsersColumns < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :name, :username
    rename_column :users, :digest, :password_digest
  end
end
