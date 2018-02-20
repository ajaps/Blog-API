require "rails_helper"

RSpec.describe User, type: :model do
  let(:user_detail) do
    {
      "first_name": "franklin",
      "last_name": "Trump",
      "email": "johndoe@goal.com",
      "gender": "Male",
      "role": "Tester"
    }
  end

  let(:invalid_details) do
    {
      "first_name": "franklin",
      "last_name": "Trump",
      "email": "johndoe",
      "gender": " ",
      "role": "Tester"
    }
  end

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
    it { is_expected.to validate_acceptance_of(:gender) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_uniqueness_of(:user_id) }
  end

  describe ".generate_user_id" do
    context "when generating user id" do
      it "returns a string" do
        expect(User.generate_user_id).to be_a(String)
      end

      it "returns a unique string" do
        first_user_id = User.generate_user_id
        second_user_id = User.generate_user_id

        expect(first_user_id).not_to eq(second_user_id)
      end
    end
  end

  describe ".create_user" do
    context "when given valid user information" do
      let!(:new_user) do
        User.create_user(user_detail).save!
      end

      it "creates a record in the database with the supplied information" do
        expect(User.last.email).to eql(user_detail[:email])
        expect(User.last.role).to eql(user_detail[:role])
      end
    end

    context "when any given value is empty or invalid" do
      let!(:invalid_user) do
        User.create_user(invalid_details)
      end

      it "creates a record in the database with the supplied information" do
        expect(invalid_user.valid?).to eql(false)
        expect { invalid_user.save! }.
          to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
