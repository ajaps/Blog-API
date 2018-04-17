class UserController < ApplicationController
  include Response

  def create
    new_user = User.create_user user_params
    passw_instance = PrivateInfo.save_private_info(new_user.user_id, password)

    if new_user.valid? && passw_instance.valid?
      return_user_id(new_user, passw_instance)
    else
      new_user.delete
      json_response({ errors: new_user.errors }, 422)
    end
  end

  private

  def user_params
    params.require(:user_details).
      permit(:first_name, :last_name, :gender, :role, :email)
  end

  def password
    params.require(:user_details).
      permit(:password)
  end

  def return_user_id(new_user, passw_instance)
    new_user.save!
    passw_instance.save!
    json_response({
                    message: "User created sucessfully",
                    user_id: new_user.user_id
                  }, 201)
  end
end
