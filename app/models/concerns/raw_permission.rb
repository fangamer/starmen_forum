module RawPermission
  PERMISSIONS_ORIG = [
    {
      "id"=>1,
      "name"=>"Forum_Read",
      "comment"=>"Enables/Disables the user to read the forum in the variable.",
      "model"=>"Forum",
      "option"=>"SELECT",
    },
    {
      "id"=>2,
      "name"=>"Forum_Readall",
      "comment"=>
      "Enables the user to read ALL THE FORUMS. (Security Warning: I mean ALL! Including super secret staff information!)",
      "model"=>"Forum",
      "option"=>"FORCE",
    },
    {
      "id"=>4,
      "name"=>"Disable_Matocode",
      "comment"=>
      "Enabling this permission disables the conversion of matocode. Useful for punishment or enabling HTML.",
      "model"=>nil,
      "option"=>nil,
    },
    {
      "id"=>5,
      "name"=>"Ban_From_Forum",
      "comment"=>
      "Bans the user completely from the forum. They cannot read or post anything at all.",
      "model"=>nil,
      "option"=>nil,
    },
    {
      "id"=>6,
      "name"=>"Moderator",
      "comment"=>
      "WARNING! This gives the user the ability to moderator tools like the IP checker! Grants special abilities to override checks for things like topic/message locking.",
      "model"=>"Forum",
      "option"=>"SELECT",
    },
    {
      "id"=>7,
      "name"=>"Forum_Edit",
      "comment"=>
      "Enables/Disables the User from Editing a post in this specific forum. (Requires ability to read the post first.)",
      "model"=>"Forum",
      "option"=>"SELECT",
    },
    {
      "id"=>8,
      "name"=>"Forum_Editall",
      "comment"=>
      "Enables/Disables the User's ability to edit any and/or ALL posts. (Requires ability to read the post first.)",
      "model"=>"Forum",
      "option"=>"FORCE",
    },
    {
      "id"=>9,
      "name"=>"Forum_Delete",
      "comment"=>
      "Enables/Disables the user to 'delete' the message. This does not actually delete the message, but rather displays a 'Message was deleted' error. (Requires ability to both Read and Edit post before deleting.)",
      "model"=>"Forum",
      "option"=>"SELECT",
    },
    {
      "id"=>10,
      "name"=>"Forum_Deleteall",
      "comment"=>
      "Enables/Disables the user to 'delete' all messages. This does not actually delete the message, but rather displays a 'Message was deleted' error. (Requires ability to both Read and Edit post before deleting.)",
      "model"=>"Forum",
      "option"=>"FORCE",
    },
    {
      "id"=>11,
      "name"=>"Forum_Infract",
      "comment"=>
      "Enables/Disables the user the ability to infract bad messages in the given forum.",
      "model"=>"Forum",
      "option"=>"SELECT",
    },
    {
      "id"=>12,
      "name"=>"Forum_Infractall",
      "comment"=>
      "Enables/Disables the user the ability to infract bad messages in all forums.",
      "model"=>"Forum",
      "option"=>"FORCE",
    },
    {
      "id"=>13,
      "name"=>"Forum_New_Message",
      "comment"=>
      "Enables/Disables the user the ability to reply in the given forum.",
      "model"=>"Forum",
      "option"=>"SELECT",
    },
    {
      "id"=>14,
      "name"=>"Forum_New_Message_Overall",
      "comment"=>"Enables/Disables the user the ability to reply in all forums.",
      "model"=>"Forum",
      "option"=>"FORCE",
    },
    {
      "id"=>15,
      "name"=>"Forum_New_Topic",
      "comment"=>
      "Enables/Disables the user the ability to create a new topic in the given forum.",
      "model"=>"Forum",
      "option"=>"SELECT",
    },
    {
      "id"=>16,
      "name"=>"Forum_New_Topic_Overall",
      "comment"=>
      "Enables/Disables the user the ability to create a new topic in all forums.",
      "model"=>"Forum",
      "option"=>"FORCE",
    },
    {
      "id"=>17,
      "name"=>"Forum_Lock_Topic",
      "comment"=>
      "Enables/Disables the user the ability to lock a topic in the given forum.",
      "model"=>"Forum",
      "option"=>"SELECT",
    },
    {
      "id"=>18,
      "name"=>"Forum_Lock_Topic_Overall",
      "comment"=>
      "Enables/Disables the user the ability to lock a topic in all forums.",
      "model"=>"Forum",
      "option"=>"FORCE",
    },
    {
      "id"=>19,
      "name"=>"Forum_Sticky_Topic",
      "comment"=>
      "Enables/Disables the user the ability to sticky a topic in the given forum.",
      "model"=>"Forum",
      "option"=>"SELECT",
    },
    {
      "id"=>20,
      "name"=>"Forum_Sticky_Topic_Overall",
      "comment"=>
      "Enables/Disables the user the ability to sticky a topic in all forums.",
      "model"=>"Forum",
      "option"=>"FORCE",
    },
    {
      "id"=>21,
      "name"=>"Forum_Move_Topic",
      "comment"=>
      "Enables/Disables the user the ability to move a topic in the given forum.",
      "model"=>"Forum",
      "option"=>"SELECT",
    },
    {
      "id"=>22,
      "name"=>"Forum_Move_Topic_Overall",
      "comment"=>
      "Enables/Disables the user the ability to move a topic in all forums.",
      "model"=>"Forum",
      "option"=>"FORCE",
    },
    {
      "id"=>23,
      "name"=>"Forum_SplitMerge_Message",
      "comment"=>
      "Enables/Disables the user the ability to split/merge a topic in the given forum.",
      "model"=>"Forum",
      "option"=>"SELECT",
    },
    {
      "id"=>24,
      "name"=>"Forum_SplitMerge_Message_Overall",
      "comment"=>
      "Enables/Disables the user the ability to split/merge a topic in all forums.",
      "model"=>"Forum",
      "option"=>"FORCE",
    },
    {
      "id"=>25,
      "name"=>"Forum_Edit_Topic",
      "comment"=>
      "Enables/Disables the user the ability to edit a topic in the given forum.",
      "model"=>"Forum",
      "option"=>"SELECT",
    },
    {
      "id"=>26,
      "name"=>"Forum_Edit_Topic_Overall",
      "comment"=>
      "Enables/Disables the user the ability to edit a topic in all forums.",
      "model"=>"Forum",
      "option"=>"FORCE",
    },
    {
      "id"=>27,
      "name"=>"Administrator",
      "comment"=>
      "Gives the users Administrator access on the Forums. WARNING: THIS ALLOWS THE USER TO VIEW AND EDIT SEE ALL FORUMS!!",
      "model"=>"",
      "option"=>"FORCE",
    },
    {
      "id"=>28,
      "name"=>"Moderator_All",
      "comment"=>"Enables/Disables the user to moderate all forums.",
      "model"=>"Forum",
      "option"=>"FORCE",
    },
    {
      "id"=>29,
      "name"=>"Forum_Post_Image",
      "comment"=>"Enables/Disables the user to post a image in the variable.",
      "model"=>"Forum",
      "option"=>"SELECT",
    },
    {
      "id"=>30,
      "name"=>"Forum_Message_Attachment_Overall",
      "comment"=>"Enables/Disables the user to attach files to all forums.",
      "model"=>"Forum",
      "option"=>"FORCE",
    },
    {
      "id"=>31,
      "name"=>"Forum_Message_Attachment",
      "comment"=>"Enables/Disables the user to attach files to a specific forum.",
      "model"=>"Forum",
      "option"=>"Select",
    },
    {
      "id"=>32,
      "name"=>"Forum_UnDeleteMessage",
      "comment"=>
      "Enables the user to undelete any deleted post in a certain forum.",
      "model"=>"Forum",
      "option"=>"SELECT",
    },
    {
      "id"=>33,
      "name"=>"Forum_UnDeleteMessage_All",
      "comment"=>"Enables the user to undelete any deleted post.",
      "model"=>"Forum",
      "option"=>"FORCE",
    },
    {
      "id"=>34,
      "name"=>"View_UberCMS",
      "comment"=>"Enables the user to view the UberCMS.",
      "model"=>nil,
      "option"=>"FORCE",
    },
    # {
    #   "id"=>35,
    #   "name"=>"User_Suspend",
    #   "comment"=>
    #   "Allows the user to suspend other users for up to a certain number of hours.",
    #   "model"=>"Integer",
    #   "option"=>"SELECT",
    # },
  ]
  PERMISSIONS = Hash[PERMISSIONS_ORIG.map{|x| [x['id'],x]}]
  PERMISSIONS_FROM_NAME = Hash[PERMISSIONS_ORIG.map{|x| [x['name'],x]}]
  PERMISSIONS_SELECT = Hash[PERMISSIONS_ORIG.map{|x| [x['name'],x['id']]}]

end
