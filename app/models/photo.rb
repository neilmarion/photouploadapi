class Photo < ActiveRecord::Base
  #attr_accessible :name, :avatar_path, :avatar
  has_attached_file :avatar, :path => ":rails_root/public/avatars/:filename"
end
