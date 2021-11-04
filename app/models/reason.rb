class Reason < ApplicationRecord
  has_many :posts_reasons
  has_many :posts, through: :posts_reasons

  validates :name, :presence => true

  def most_recent
    Rails.cache.fetch "reason_#{self.id}_most_recent", :expires_in => 1.hour do
      self.posts.order(:created_at => :desc).first
    end
  end
end
