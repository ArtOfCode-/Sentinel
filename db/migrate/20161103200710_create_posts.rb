class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :link
      t.datetime :post_creation_date
      t.string :user_link
      t.string :username
      t.integer :user_reputation
      t.float :nato_score

      t.timestamps
    end
  end
end
