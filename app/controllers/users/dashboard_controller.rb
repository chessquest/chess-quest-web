class Users::DashboardController < ApplicationController
  def show
    conn = Faraday.new(url: "https://chess-quest-api.herokuapp.com/api/v1/users/#{current_user.id}/")

    response = conn.get('quests') do |req|
      req.params[:status] = 'in_progress'
    end
    
    data = JSON.parse(response.body, symbolize_names: true)
    require 'pry'; binding.pry
    return @quests = nil if data[:data].blank?

    data = data[:data]

    @quests = data.map do |datum|
      Quest.new(datum)
    end

    @current_game = nil
  end
end
