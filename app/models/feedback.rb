class Feedback < ApplicationRecord
  belongs_to :post
  belongs_to :feedback_type
end
