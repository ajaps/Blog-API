class PrivateInfo < ApplicationRecord
  belongs_to :user

  validates :password_digest,
            presence: true,
            allow_blank: false,
            length: { minimum: 6 }

  validates_associated :user

  has_secure_password

  def self.save_private_info(user_id, user_details)
    user_details[:user_id] = user_id
    create(user_details)
  end
end
