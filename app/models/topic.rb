class Topic < ApplicationRecord
  include BackwardsCompat

  has_many :messages, ->{order(created_at: :asc)}, inverse_of: :topic
  belongs_to :latest_message, :class_name => "Message", :foreign_key => "latest_message_id"
  belongs_to :forum, inverse_of: :topics
  belongs_to :creator, :class_name => "User", :foreign_key => "user_id"
  belongs_to :sprite
  belongs_to :contest
  has_many :reads, :dependent=>:delete_all
  belongs_to :emblem
  has_many :subscriptions, :dependent=>:destroy

  #todo: validations

  #todo: calculate replies
  #todo: calculate latest

  def get_permalink
    tempvar = String.new(self.name.gsub(/[^a-zA-Z0-9]/,"-").gsub(/-{2,}/,"-").gsub(/^-/,'').gsub(/-$/,''))
    if Topic.exists?({:permalink=>tempvar,:forum_id=>self.forum_id})
      number = 1
      temp = tempvar + "-" + number.to_s
      while Topic.exists?({:permalink=>temp,:forum_id=>self.forum_id}) && number < 1000
        number += 1
        temp = tempvar + "-" + number.to_s
      end
      tempvar = temp
    end
    tempvar
  end

  def set_permalink
    self.permalink = get_permalink
  end

  def truncate_name(words = 5)
    self.name.split[0..words].join(" ") + (self.name.split.size > (words+1) ? "..." : "")
  end

  def can_create?
    return true if Rails.env.development?
    false
  end

  def can_edit?
    return true if Rails.env.development?
    false
  end

  def can_lock?
    return true if Rails.env.development?
    false
  end

  def can_sticky?
    return true if Rails.env.development?
    false
  end

  def can_move?
    return true if Rails.env.development?
    false
  end

  def can_splitmerge?
    return true if Rails.env.development?
    false
  end

  def url
    return "/forum/topic/#{self.id}" if self.forum.blank? || self.forum.url.blank?
    "#{self.forum.url}/#{self.permalink}"
  end
  alias_method :URL, :url
end
