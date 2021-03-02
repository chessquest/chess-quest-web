class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :current_user_signed_in?

  def index
  end

end
