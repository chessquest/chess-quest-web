class QuestsController < ApplicationController

  def create
    conn = Faraday.new(url: "https://chess-quest-api.herokuapp.com/api/v1/users/#{current_user.id}/")
    response = conn.post('quests')

    data = JSON.parse(response.body, symbolize_names: true)

    redirect_to dashboard_path
  end

end
