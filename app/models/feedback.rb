class Feedback < ApplicationRecord
  belongs_to :post
  belongs_to :feedback_type

  validates :feedback_type, :presence => true
  validates :post, :presence => true
end
