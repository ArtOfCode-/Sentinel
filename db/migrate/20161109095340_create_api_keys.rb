class CreateApiKeys < ActiveRecord::Migration[5.0]
  def change
    create_table :api_keys do |t|
      t.string :name
      t.string :key
      t.string :repo
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
