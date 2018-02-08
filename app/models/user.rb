require "fancy_id"

class User < ApplicationRecord
  validates_presence_of :role, :role
  validates_uniqueness_of :email
  validates :gender, presence: true, acceptance: { accept: %w(Male Female) }

  has_many :blog_posts

  def self.generate_user_id
    generate_id
  end
end
