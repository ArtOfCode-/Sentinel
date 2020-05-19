class FeedbacksChatUsernameIndex < ActiveRecord::Migration[5.0]
  def change
    add_index :feedbacks, :chat_username
  end
end
