class Emblem < ApplicationRecord
  has_many :emblemeds
  has_many :users, :through=>:emblemeds

  before_save :admins_only

  def permission_or_group
    if self.permission_name
      "P:#{self.permission_name}"
    elsif self.group_id
      "G:#{self.group_id}"
    else
      nil
    end
  end

  def self.permission_or_group_options
    ret = [["Permission:",nil]]
    permissions = %w(Administrator Moderator_All Moderator)
    permissions.each{|permission| ret << [(permission == permissions.last ? "&#9492; " : "&#9500; ")+permission,"P:#{permission}"]}
    groups = Group.all
    ret << ["Member of Group:",nil]
    groups.each{|group| ret << ["#{(group == groups.last ? "&#9492; " : "&#9500; ")}#{group.name}","G:#{group.id}"]}
    ret
  end

  def permission_or_group=(string)
    a = string.split(":")
    case a.first
    when "P"
      self.permission_name = a.last
      self.group_id = nil
    when "G"
      self.permission_name = nil
      self.group_id = a.last
    else
      self.permission_name = nil
      self.group_id = nil
    end
  end

  def admins_only
    raise SecurityException, "You are not allowed to edit system preferences!" unless $logged_in_user.has_permission("Administrator")
  end
end
