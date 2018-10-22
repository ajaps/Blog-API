require "fancy_id"

class User < ApplicationRecord
  self.primary_key = :uuid

  validates :email,
            presence: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
            allow_blank: false
  validates :uuid,
            presence: true,
            allow_blank: false
  validates_uniqueness_of :uuid, :email
  validates :gender, presence: true, acceptance: { accept: %w(Male Female) }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true

  has_many :blog_posts
  # has_one :private_info, dependent: :destroy

  before_validation :generate_uuid, on: :create

  has_secure_password

  private

  def generate_uuid
    self.uuid = generate_id
  end
end
