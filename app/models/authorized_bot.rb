class AuthorizedBot < ApplicationRecord
  validates :name, :presence => true, :length => { :minimum => 1, :maximum => 50 }
  validates :key, :presence => true, :length => { :is => 64 }
end
