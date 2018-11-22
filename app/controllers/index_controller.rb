class IndexController < ApplicationController

  skip_before_action :authenticate_request!, only:  :index

  def index
    render json: { messgae: 'Welcome to Blog API' }
  end
end
