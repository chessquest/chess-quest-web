class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :current_user_signed_in?

  def current_user_signed_in?
    redirect_to dashboard_path if current_user
  end
end
