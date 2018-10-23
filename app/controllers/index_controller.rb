class IndexController < ApplicationController
  def index
    render json: { messgae: 'Welcome to Blog API' }
  end
end
