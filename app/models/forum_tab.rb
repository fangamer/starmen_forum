class ForumTab < ApplicationRecord
  validates_presence_of :name,:link,:forum_id
  belongs_to :sprite
end
