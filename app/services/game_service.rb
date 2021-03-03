class GameService

	class << self

    def get_top_3_quest_streak
      data = conn.get("top_quests")
      x = parse(data)[:data].map do |data_entry|
        data_entry[:attributes][:streak]
      end
    end

    
    private
    
    def conn
      Faraday.new(url: "https://chess-quest-api.herokuapp.com/api/v1/")
    end
    
    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
    
  end
end