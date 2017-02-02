class Feedback < ApplicationRecord
  belongs_to :post
  belongs_to :feedback_type

  validates :feedback_type, :presence => true
  validates :post, :presence => true

  after_create do
    Rails.cache.delete("post_#{self.post.id}_majority_feedback")
    Feedback.where(:chat_id => self.chat_id, :post_id => self.post_id).where.not(:id => @feedback.id).destroy_all
  end
end
