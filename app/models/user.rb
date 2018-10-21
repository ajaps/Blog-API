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
  # has_one :private_info, dependent: :destroy

  before_validation :generate_user_id, on: :create

  has_secure_password

  private

  def generate_user_id
    self.user_id = generate_id
  end
end
