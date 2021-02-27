class Game
  attr_reader :id, :quest_id, :status, :fen

  def initialize(data)
    @id = data[:id]
    @quest_id = data[:attributes][:quest_id]
    @status = data[:attributes][:status]
    @fen = data[:attributes][:current_fen]
  end
end