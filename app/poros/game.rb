class Game
  attr_reader :id, :quest_id, :status, :fen

  def initialize(data)
    @id = data[:id]
    @quest_id = data[:relationships][:quest][:data][:id]
    @status = data[:attributes][:status]
    @fen = data[:attributes][:current_fen]
  end
end