class UserController < ApplicationController
  include Response

  skip_before_action :authenticate_request, only: :create

  def index
    users = User.all.select(:uuid, :first_name, :last_name, :gender, :role)

    json_response({ users: users }, 200)
  end

  def show
    user = User.where(uuid: params[:id]).select(:uuid, :first_name, :last_name, :gender, :role)

    json_response({ user: user }, 200)
  end

  def create
    new_user = User.create!(user_params)

    if new_user.save
      auth_token = AuthenticateUser.new(new_user.email, new_user.password).call.result

      json_response({
                    message: "User created sucessfully",
                    user_email: new_user.email,
                    token: auth_token
                  }, 201)
    else

      json_response({ errors: new_user.errors }, 422)
    end
  end

  def update
    updated_user = false

    if @current_user.id == params[:id]
      updated_user = User.find_by(uuid: params[:id]).update_attributes!(user_params)
      # updated_user = User.where(id: params[:id]).update_all(user_params)
    else
      return json_response({
                    message: "Admin rights is required to update another users information",
                  }, 403)
    end

    if updated_user
      return json_response({
                      message: "User updated sucessfully",
                      updated: updated_user
                    }, 200)
    end

      json_response({
                    message: "An Error occured while updating user",
                    updated: updated_user
                  }, 200)
  end

  def destroy
    if @current_user.id == params[:id]
      User.find(params[:id]).destroy

      return json_response({ message: 'User profile deleted sucessfully'}, 200)
    else

      json_response({ message: "You are not alowed to delete another user's profile"}, 403)
    end
  end

  private

  def user_params
    params.require(:user_details).
      permit(:first_name, :last_name, :gender, :email, :password)
  end
end
