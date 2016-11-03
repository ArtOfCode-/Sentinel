class AddPostsReasonsTable < ActiveRecord::Migration[5.0]
  def self.up
    create_table :posts_reasons do |t|
      t.integer :post_id
      t.integer :reason_id
    end
  end

  def self.down
    drop_table :posts_reasons
  end
end
