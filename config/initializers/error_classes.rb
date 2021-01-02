module StarmenForum
  # superclass of custom errors
  class StarmenForumError < StandardError
  end

  # raises if a login is required to perform an action
  class LoginRequired < StarmenForumError
  end
end
