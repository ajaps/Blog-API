require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Associations" do
    it { is_expected.to have_many(:blog_posts) }
  end

  describe "Validations" do
    subject do
      User.new(
        user_id: User.generate_user_id
      )
    end
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to validate_presence_of(:gender) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_uniqueness_of(:user_id) }
  end
end
