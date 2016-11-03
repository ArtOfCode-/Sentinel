class User < ApplicationRecord
  after_save :promote_if_first

  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private
  def promote_if_first
    if self.id == 1
      self.add_role(:admin)
    end
  end
end
