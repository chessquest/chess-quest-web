require 'rails_helper'

describe Game do
  describe "The Game" do
    before :each do
      @data = {
        "data":{
          "id":"1",
          "type":"game",
          "attributes":{
            "status":"in_progress",
            "starting_fen":"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
            "current_fen":"rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1"
          },
          "relationships":{
            "quest":{
              "data":{
                  "id":"1",
                  "type":"quest"
              }
            }
          }
        }
      }
      @game = Game.new(@data)
    end

    it 'has attributes' do
      expect(@game.id).to eq(@data[:data][:id])
      expect(@game.status).to eq(@data[:data][:attributes][:status])
      expect(@game.quest_id).to eq(@data[:data][:relationships][:quest][:data][:id])
      expect(@game.fen).to eq(@data[:data][:attributes][:current_fen])
    end
  end
end
