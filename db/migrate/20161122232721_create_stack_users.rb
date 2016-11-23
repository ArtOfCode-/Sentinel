class CreateStackUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :stack_users do |t|
      t.references :user, foreign_key: true
      t.integer :network_id
      t.integer :chat_so_id
      t.integer :chat_se_id
      t.integer :chat_mse_id
      t.string :access_token

      t.timestamps
    end
  end
end
