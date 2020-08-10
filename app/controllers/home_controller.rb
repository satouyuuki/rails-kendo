class HomeController < ApplicationController
  protect_from_forgery with: :exception
  def index
    render template: 'home/index'
  end
end
