class User < ApplicationRecord
  has_many :permissions
  has_and_belongs_to_many :groups
  has_many :punishments, ->{where(Punishment.arel_table[:until].gt(Time.now))}
  has_many :private_messages, ->{where(hidden_in_inbox:false)}, :foreign_key=>"owner_id"
  has_many :sent_private_messages, ->{where(hidden_in_sent_box:false)}, :class_name=>"PrivateMessage", :foreign_key=>"sender_id"
  has_and_belongs_to_many :badges
  has_many :infractions
  has_one :avatar
  has_many :raw_permissions_users
  has_many :raw_permissions,:through=>:raw_permissions_users
  has_many :reads
  has_many :acls
  serialize :info
  has_many :forum_reads
  belongs_to :sprite
  has_many :messages, inverse_of: :creator
  belongs_to :theme
  serialize :preferences
  has_many :friends
  has_many :submissions
  has_many :emblemeds, :dependent => :delete_all
  has_many :emblems, :through=>:emblemeds
  belongs_to :emblem
  belongs_to :infraction_punishment

  def Permissions
    ActiveSupport::Deprecation.warn("Changed #Permissions to #permissions")
    permissions
  end

  def has_permission(name,enable = true)
    perm = self.permissions.reject{|p| p.permission != name || p.value != enable}.flatten
    return false if perm.blank?
    return perm.first
  end

  def admin?
    has_permission("Administrator")
  end

  def has_permission_of(name,id,enable = true)
    perm = self.Permissions.reject{|p| p.permission != name || p.individual_id != id || p.value != enable}.flatten
    return false if perm.blank?
    return perm.first
  end
end
