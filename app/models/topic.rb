class Topic < ApplicationRecord
  include BackwardsCompat

  has_many :messages, ->{order(created_at: :asc)}
  belongs_to :latest_message, :class_name => "Message", :foreign_key => "latest_message_id"
  belongs_to :forum
  belongs_to :creator, :class_name => "User", :foreign_key => "user_id"
  belongs_to :sprite
  belongs_to :contest
  has_many :reads, :dependent=>:delete_all
  belongs_to :emblem
  has_many :subscriptions, :dependent=>:destroy

  def can_create?
    return true if Rails.env.development?
    false
  end

  def url
    return "/forum/topic/#{self.id}" if self.forum.blank? || self.forum.url.blank?
    "#{self.forum.url}/#{self.permalink}"
  end
  alias_method :URL, :url
end
