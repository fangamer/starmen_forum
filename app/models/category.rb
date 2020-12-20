class Category < ApplicationRecord
  include BackwardsCompat

  has_many :forums

  validates_presence_of :name,:nickname
end
