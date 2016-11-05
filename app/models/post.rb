class Post < ApplicationRecord
  has_and_belongs_to_many :reasons

  validates :title, :presence => true
  validates :body, :presence => true
  validates :link, :presence => true
  validates :post_creation_date, :presence => true
  validates :user_link, :presence => true
  validates :username, :presence => true
  validates :user_reputation, :presence => true
  validates :nato_score, :presence => true, :inclusion => -30..30   # -30..30 as a sanity check rather than a validation
end
