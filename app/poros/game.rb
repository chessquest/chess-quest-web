class Game
  attr_reader :id, :quest_id, :status, :fen

  def initialize(data)
    @id = data[:data][:id]
    @quest_id = data[:data][:relationships][:quest][:data][:id]
    @status = data[:data][:attributes][:status]
    @fen = data[:data][:attributes][:current_fen]
  end
end
