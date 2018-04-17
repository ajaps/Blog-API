class PrivateInfo < ApplicationRecord
  belongs_to :user

  validates :password,
            presence: true,
            allow_blank: false,
            length: { minimum: 6 }

  validates_associated :user

  def self.save_private_info(user_id, password)
    password[:user_id] = user_id
    create(password)
  end
end
