class GamesController < ApplicationController
  def create
    conn = Faraday.new(url: "https://chess-quest-api.herokuapp.com/api/v1/users/#{current_user.id}/")
    response = conn.post('games') do |req|
      req.params['find_player'] = 'magnuscarlsen'
    end

    data = JSON.parse(response.body, symbolize_names: true)

    redirect_to gameplay_path(data[:data][:id])
  end
end