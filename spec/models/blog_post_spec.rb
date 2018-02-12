require 'rails_helper'

RSpec.describe BlogPost, type: :model do
  let(:blog_post) { create :blog_post }
  let(:post_no_user) do
    BlogPost.create(
      title: 'First post', content: 'Fish fish', user_id: 5, view_rights: 'admin'
    )
  end

  describe "Associations" do
    it { is_expected.to belong_to(:user) }
    it 'must have an existing user id' do
      expect{ post_no_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:view_rights) }
    it { is_expected.to validate_uniqueness_of(:title) }
    # it 'goal' do
    #   puts blog_post
    # end
  end
end
