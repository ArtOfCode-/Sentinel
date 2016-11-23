class AddAuthStateToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :auth_state, :string
  end
end
