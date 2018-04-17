require "fancy_id"

class User < ApplicationRecord
  self.primary_key = :user_id

  validates :email,
            presence: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
            allow_blank: false
  validates :user_id,
            presence: true,
            allow_blank: false
  validates_uniqueness_of :user_id, :email
  validates :gender, presence: true, acceptance: { accept: %w(Male Female) }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true

  has_many :blog_posts
  has_one :private_info, dependent: :destroy

  def self.generate_user_id
    generate_id
  end

  def self.create_user(user_details)
    user_details[:user_id] = generate_user_id
    create(user_details)
  end
end
