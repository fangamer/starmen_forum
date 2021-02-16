# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user=nil)
    # all users, at least logged out, can read public forums
    can :read, Forum, read_by_column: true

    return unless user

    # in cancancan, there are two special actions and models
    # :manage as an action means can do anything
    # :all as a model means everything
    # so `can :manage, :all` means can do anything to everything; which is an admin. so admins have full access, and return because that's end of story
    if user.admin?
      can :manage, :all
      return
    end

    # for each permission, process them in a special function (this is easier to read than a massive ugly if/elsif or a bunch of case/whens)
    user.permissions.each do |permission|
      permission_name = :"process_permission_#{permission[:name]}"
      __send__(:"process_permission_#{permission[:name]}",permission) if self.methods.include?(permission_name)
    end
  end

  # handle the Forum_Read Permission
  def process_permission_Forum_Read(permission)
    return if permission[:individual_id].blank? || permission[:individual_id].to_i <= 0
    if permission[:value] === true
      can :read, Forum, id:permission[:individual_id].to_i
    else
      cannot :read, Forum, id:permission[:individual_id].to_i
    end
  end

  if Rails.env.development?
    RawPermission::PERMISSIONS_FROM_NAME.each do |name,permission|
      permission_name = :"process_permission_#{name}"
      unless self.instance_methods.include?(permission_name)
        define_method(permission_name) do |permission|
          Rails.logger.debug("Unknown Permission Ability Method #{permission_name}")
        end
      end
    end
  end
end
