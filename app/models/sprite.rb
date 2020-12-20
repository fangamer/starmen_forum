class Sprite < ApplicationRecord

  def public_filename
    folder = ("%08d" % (self.id)).scan(/..../).join("/")
    "https://ssl-forum-files.fobby.net/sprites/#{folder}/#{filename}"
  end
end
