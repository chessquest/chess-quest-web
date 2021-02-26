class Users::DashboardController < ApplicationController
  def show
    conn = Faraday.new(url: "https://chess-quest-api.herokuapp.com/api/v1/users/#{current_user.id}/")

    response = conn.get('quests') do |req|
      req.params[:status] = 'in_progress'
    end

    return @current_quest = nil if response.body.blank?

    data = JSON.parse(response.body, symbolize_names: true)
    @current_quest = data
  end
end
