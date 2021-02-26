class Users::QuestsController < ApplicationController

  def create
    conn = Faraday.new(url: "https://chess-quest-api.herokuapp.com/api/v1/users/#{current_user.id}/")
    require 'pry'; binding.pry
    response = conn.post('quests')

    data = JSON.parse(response.body, symbolize_names: true)

    redirect_to users_dashboard_path(current_user)
  end

end
