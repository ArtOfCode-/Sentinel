class PostsReason < ApplicationRecord
  belongs_to :post, counter_cache: :reasons_count
  belongs_to :reason, counter_cache: :posts_count
end
