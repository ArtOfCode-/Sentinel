class Post < ApplicationRecord
  has_and_belongs_to_many :reasons
  has_many :feedbacks, dependent: :destroy
  has_many :feedback_types, through: :feedbacks

  validates :title, :presence => true
  validates :body, :presence => true
  validates :link, :presence => true, :uniqueness => true
  validates :post_creation_date, :presence => true
  validates :user_link, :presence => true
  validates :username, :presence => true
  validates :user_reputation, :presence => true
  validates :nato_score, :presence => true, :inclusion => -30..30   # -30..30 as a sanity check rather than a validation

  def majority_feedback
    feedback_types = self.feedback_types

    # Find the most frequent, from http://stackoverflow.com/a/412177/1849664
    frequencies = feedback_types.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    return frequencies.max_by { |v| frequencies[v] }
  end
end
