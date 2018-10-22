require "rails_helper"

RSpec.describe UserController, type: :controller do
  let(:json) { response.body }
  let(:user_detail) do
    {
      "first_name": "franklin",
      "last_name": "Trump",
      "email": "johndoe@goal.com",
      "gender": "Male",
      "role": "Tester",
      "password": "goal.com"
    }
  end

  describe "#create" do
    context "when user information is valid" do
      let(:create_user) do
        post :create, params: { user_details: user_detail }, xhr: true
      end

      it "creates a new record in the User table" do
        expect{ create_user }.to change { User.count }.by(1)
      end

      it "returns the user id" do
        response = create_user
        expect(response.body).to include User.last.user_id
      end

      it "returns a 200 status" do
        expect(create_user).to have_http_status 201
      end
    end

    context "when user information is invalid" do
      let!(:create_user_with_invalid_details) do
        user_detail[:email] = "franklinAjaps"
        post :create, params: { user_details: user_detail }, xhr: true
      end

      it "returns the relevant error information" do
        expect(json).to include "Email is invalid"
      end

      it "returns a 422 status" do
        expect(create_user_with_invalid_details).to have_http_status 422
      end
    end
  end
end
