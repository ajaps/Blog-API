class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  include ExceptionHandler

  # [...]
  private
  def authenticate_request
    return if (params[:controller] == 'user' && params[:action] == 'create')
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end
