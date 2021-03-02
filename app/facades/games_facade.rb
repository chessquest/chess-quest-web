class GamesFacade
  def self.new_game(params, id)
    response = faraday(id).post('games') do |req|
      req.params['find_player'] = params[:player].downcase
    end

    parse(response)
  end

  private

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.faraday(id)
    Faraday.new(url: "https://chess-quest-api.herokuapp.com/api/v1/users/#{id}/")
  end
end
