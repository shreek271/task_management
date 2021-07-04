class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  include Pundit

  rescue_from ActionController::RoutingError, with: :page_error
  rescue_from Pundit::NotAuthorizedError, with: :page_error
  rescue_from ActiveRecord::RecordNotFound, with: :page_error

  # def error_404
  # end

  # def user_not_authorized
  # end

  def page_error
    render 'main_pages/page_error', layout: 'application', status: 500
  end
end
