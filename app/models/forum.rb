class Forum < ApplicationRecord
  include BackwardsCompat

  has_many :topics, ->{order(last_message: :desc).preload(:creator)}, inverse_of: :forum
  has_many :messages, through: :topics, inverse_of: :forum
  belongs_to :category
  has_many :forum_reads
  belongs_to :sprite
  has_one :ap, :class_name=>"ForumAdvancedPermission"
  has_and_belongs_to_many :sites

  def url
    return '' unless self.category.is_a?(Category)
    '/forum/'+self.category.nickname+'/'+self.nickname
  end
  alias_method :URL, :url

  def can_splitmerge?
    return true if Rails.env.development?
    false
  end

  def is_moderator?
    ActiveSupport::Deprecation.warn("Forum#is_moderator? is moving somewhere else")
    false
  end

  def is_supermod?
    ActiveSupport::Deprecation.warn("Forum#is_supermod? is moving somewhere else")
    false
  end

  def can_post_images?
    self.allow_images
  end

  def can_attach?
    false
  end

  def self.select_options
    out = Hash.new{|h,k| h[k] = []}
    forums = Forum.preload(:category).all.to_a
    forums.sort_by!{|f| [f.category.try(:order)||9999999999999,f.order]}
    forums.each do |forum|
      out[forum.category.try(:name)||"Unknown Category"] << [forum.name,forum.id]
    end
    out
  end
end
