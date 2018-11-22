class UserController < ApplicationController
  include Response

  skip_before_action :authenticate_request!, only:  %i[ create login ]
  before_action :is_admin?, only: %i[ update destroy ]

  def index
    users = User.all.select(:uuid, :first_name, :last_name, :gender, :role)

    json_response({ users: users }, 200)
  end

  def show
    user = User.where(uuid: params[:id]).select(:uuid, :first_name, :last_name, :gender, :role)

    json_response({ user: user }, 200)
  end

  def login
    token = AuthenticateUser.new(login_params[:email], login_params[:password]).call

    if token.result
      json_response({ token: token.result }, 200)

    else
      json_response({ errors: token.errors }, 404 )
    end
  end

  def create
    new_user = User.create!(user_params)

    if new_user.save
      auth_token = AuthenticateUser.new(new_user.email, new_user.password).call.result

      json_response({ message: "User created sucessfully", user_email: new_user.email, token: auth_token }, 201)
    else

      json_response({ errors: new_user.errors }, 422)
    end
  end

  def update
    updated_user = User.find_by(uuid: params[:id]).update_attributes!(user_params)

    return json_response({ message: "User updated sucessfully", updated: updated_user }, 200) if updated_user

    json_response({ message: "An Error occured while updating user", updated: updated_user }, 400)
  end

  def destroy
    User.find(params[:id]).destroy

    return json_response({ message: 'User profile deleted sucessfully'}, 200)
  end

  private

  def user_params
    params.require(:user_details).
      permit(:first_name, :last_name, :gender, :email, :password)
  end

  def login_params
    params.require(:user_details).
      permit(:email, :password)
  end
end
