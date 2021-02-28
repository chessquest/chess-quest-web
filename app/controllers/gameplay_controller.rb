class GameplayController < ApplicationController
  def show
    conn = Faraday.new(url: "https://chess-quest-api.herokuapp.com/api/v1/")
    response = conn.get("#{params['game_id']}")

    data = JSON.parse(response.body, symbolize_names: true)
    @game = Game.new(data[:data])
  end
end
