class ApplicationController < ActionController::Base
  def index
    render template: 'index'
  end
end
