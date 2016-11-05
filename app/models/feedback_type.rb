class FeedbackType < ApplicationRecord
  has_many :feedbacks
  has_many :posts, :through => :feedbacks
end
