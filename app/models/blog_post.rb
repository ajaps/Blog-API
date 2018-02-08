class BlogPost < ApplicationRecord
  validates_presence_of :title, :content, :view_rights
end
