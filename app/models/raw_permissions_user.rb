class RawPermissionsUser < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id,:raw_permission_id

  def raw_permission
    RawPermission::PERMISSIONS[raw_permission_id]
  end

  def name
    raw_permission['name']
  end

  def comment
    raw_permission['comment']
  end

  def option
    raw_permission['option']
  end

  def model
    case raw_permission['model']
      when 'Forum' then Forum
      else nil
    end
  end

  def individual_name
    case raw_permission['model']
      when 'Forum' then Forum.find_by_id(self.individual_id).try(:name)
      else nil
    end
  end
end
