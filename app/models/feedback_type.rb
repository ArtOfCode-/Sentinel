class FeedbackType < ApplicationRecord
  has_many :feedbacks
  has_many :posts, :through => :feedbacks

  validates :name, :presence => true
  validates :short_code, :presence => true, :uniqueness => true
  validates :color, :presence => true, :uniqueness => true
  validates :character, :presence => true, :uniqueness => true
end
