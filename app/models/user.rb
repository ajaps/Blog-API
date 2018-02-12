require "fancy_id"

class User < ApplicationRecord
  self.primary_key = :user_id

  validates_presence_of :role
  validates_uniqueness_of :email, :user_id

  validates :gender, presence: true, acceptance: { accept: %w(Male Female) }

  has_many :blog_posts

  def self.generate_user_id
    generate_id
  end
end
