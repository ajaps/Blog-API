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
      let!(:create_user) do
        post :create, params: { user_details: user_detail }, xhr: true
      end

      it "returns the user id" do
        expect(json).to include User.last.user_id
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
        expect(json).to include "errors"
        expect(json).to include "\"email\":[\"is invalid\"]"
      end
    end
  end
end
