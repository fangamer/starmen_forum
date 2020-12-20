class Forum < ApplicationRecord
  include BackwardsCompat

  has_many :topics, ->{order(last_message: :desc).preload(:creator)}
  belongs_to :category
  has_many :forum_reads
  belongs_to :sprite
  has_one :ap, :class_name=>"ForumAdvancedPermission"
  has_and_belongs_to_many :sites

  def URL
    return '' unless self.category.is_a?(Category)
    '/forum/'+self.category.nickname+'/'+self.nickname
  end
end
