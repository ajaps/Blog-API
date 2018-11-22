class ApplicationController < ActionController::API
 before_action :authenticate_request!

  attr_reader :current_user

  include ExceptionHandler

  private

  def authenticate_request!
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized', message: "Invalid/missing token Sign-in or set the token under 'Authorization' in the header" }, status: 401 unless @current_user
  end

  def is_admin?
    unless @current_user.id == params[:id]
      return json_response({ message: "Admin rights is required to update another users' information", }, 403)
    end
  end
end
