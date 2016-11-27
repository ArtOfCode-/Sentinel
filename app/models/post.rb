class Post < ApplicationRecord
  has_and_belongs_to_many :reasons
  has_many :feedbacks, dependent: :destroy
  has_many :deletion_logs, dependent: :destroy

  validates :title, :presence => true
  validates :body, :presence => true
  validates :link, :presence => true, :uniqueness => true
  validates :post_creation_date, :presence => true
  validates :user_link, :presence => true
  validates :username, :presence => true
  validates :user_reputation, :presence => true
  validates :nato_score, :presence => true, :inclusion => -30..30   # -30..30 as a sanity check rather than a validation
  validate  :answer_id_exists

  def majority_feedback
    Rails.cache.fetch "post_#{self.id}_majority_feedback", :expires_in => 1.hour do
      # Yes, I did use `find_by :id` deliberately - we *want* `nil` if it can't be found.
      FeedbackType.find_by id: self.feedbacks.joins(:feedback_type).group('feedback_types.id').order('count(feedbacks.id) desc').count.first.try(:[], 0)
    end
  end

  private
  def answer_id_exists
    unless self.answer_id.present?
      errors.add(:answer_id, "must be present")
    end
  end
end
