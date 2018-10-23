class BlogPost < ApplicationRecord
  belongs_to :user

  validates_uniqueness_of :title
  validates_presence_of :content, :view_rights

  validates_associated :user
end
