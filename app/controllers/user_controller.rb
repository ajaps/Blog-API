class UserController < ApplicationController
  include Response

  def create
    new_user = User.create_user user_params
    if new_user.valid?
      new_user.save!
      json_response({
                      message: "User created sucessfully",
                      user_id: new_user.user_id
                    }, 201)

    else
      json_response({ errors: new_user.errors }, 422)
    end
  end

  private

  def user_params
    params.require(:user_details).
      permit(:first_name, :last_name, :email, :gender, :role)
  end
end
