class CreateFeedbacks < ActiveRecord::Migration[5.0]
  def change
    create_table :feedbacks do |t|
      t.references :post, foreign_key: true
      t.references :feedback_type, foreign_key: true
      t.integer :chat_id
      t.string :chat_username

      t.timestamps
    end
  end
end
