class User < ApplicationRecord
  #has_many :permissions
  has_and_belongs_to_many :groups
  has_many :punishments, ->{where(Punishment.arel_table[:until].gt(Time.now))}
  has_many :private_messages, ->{where(hidden_in_inbox:false)}, :foreign_key=>"owner_id"
  has_many :sent_private_messages, ->{where(hidden_in_sent_box:false)}, :class_name=>"PrivateMessage", :foreign_key=>"sender_id"
  has_and_belongs_to_many :badges
  has_many :infractions
  has_one :avatar
  has_many :raw_permissions_users # in the original forum, :permissions was a cache that was derived from raw_permissions_users and group membership
  # has_many :raw_permissions,:through=>:raw_permissions_users
  has_many :reads
  has_many :acls
  serialize :info
  has_many :forum_reads
  belongs_to :sprite, optional: true
  has_many :messages, inverse_of: :creator
  belongs_to :theme, optional: true
  serialize :preferences
  has_many :friends
  has_many :submissions
  has_many :emblemeds, :dependent => :delete_all
  has_many :emblems, :through=>:emblemeds
  belongs_to :emblem, optional: true
  belongs_to :infraction_punishment, optional: true

  validates :name, presence: true
  validates :email, presence: true

  def Permissions
    ActiveSupport::Deprecation.warn("Changed #Permissions to #permissions")
    permissions
  end

  def permissions
    return @_permissions if @_permissions
    @_enable_permissions = []
    @_revoke_permissions = []

    # for each raw permission, either add it to the enable or revoke array
    raw_permissions_users.each do |rp|
      permissions_ary = rp.value ? @_enable_permissions : @_revoke_permissions
      if rp.option == "SELECT"
        permissions_ary << {raw_permission_id:rp.raw_permission_id, individual_id: rp.individual_id}
      else
        permissions_ary << {raw_permission_id:rp.raw_permission_id}
      end
    end

    # uniqize them
    @_enable_permissions.uniq!
    @_revoke_permissions.uniq!

    # in short: any revoked permission will guarantee revokedness, regardless of circumstances (except Admin)
    @_permissions = []
    # so we check for anything that's on, except those that we revoked
    @_enable_permissions.each do |enabled_permission|
      # exclude revoked
      next if @_revoke_permissions.include?(enabled_permission)
      enabled_permission[:value] = true # mark as enabled
      @_permissions << enabled_permission
    end
    # and then explicitly revoke those we don't want
    @_revoke_permissions.each do |revoked_permissions|
      revoked_permissions[:value] = false # mark as revoked
      @_permissions << revoked_permissions
    end

    # and add names
    @_permissions.each do |permission|
      permission_entry = RawPermission::PERMISSIONS[permission[:raw_permission_id]]
      permission[:name] = permission_entry['name']
      if permission_entry['option'] == "SELECT" && permission_entry['model'] == 'Forum'
        permission[:individual_name] = Forum.find_by_id(permission[:individual_id]).try(:name)
      elsif permission_entry['option'] == "FORCE"
        permission[:individual_name] = "ALL"
      end
    end
    @_permissions
  end

  def has_permission(name,enable = true)
    permissions.detect{|permission| permission[:name] == name && permission[:value] === enable}
  end

  def admin?
    has_permission("Administrator")
  end

  def has_permission_of(name,id,enable = true)
    permissions.detect{|permission| permission[:name] == name && permission[:value] === enable && permission[:individual_id] == id}
  end

  def email_confirmed
    self.email_validation.blank?
  end

  def email_confirmed=(updated_value)
    # do nothing if already confirmed
    return true if email_confirmed
    # if we are sending false, don't do anything
    return false if updated_value.blank? || updated_value === false || updated_value == "0" || updated_value == 0
    # this method is from an admin, so we force the validation to be true
    self.email_validation = nil
  end
end
