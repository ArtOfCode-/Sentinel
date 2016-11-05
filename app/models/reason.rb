class Reason < ApplicationRecord
  has_and_belongs_to_many :posts

  def most_recent
    Rails.cache.fetch "reason_#{self.id}_most_recent", :expires_in => 1.hour do
      self.posts.order(:created_at => :desc).first
    end
  end
end
