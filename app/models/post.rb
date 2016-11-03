class Post < ApplicationRecord
  has_and_belongs_to_many :reasons
end
