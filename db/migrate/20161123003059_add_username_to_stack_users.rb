class AddUsernameToStackUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :stack_users, :username, :string
  end
end
