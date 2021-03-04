require 'rails_helper'

describe Quest do
  describe "The Quest" do
    before :each do
      @data = {
        "data":{
           "id":"1",
           "type":"quest",
           "attributes":{
              "status":"in_progress",
              "user_id":1
           },
           "relationships":{
              "games":{
                 "data":[
                    {
                       "id":"1",
                       "type":"game"
                    },
                    {
                       "id":"2",
                       "type":"game"
                    },
                    {
                       "id":"3",
                       "type":"game"
                    }
                 ]
              }
           }
        },
        "included":[
           {
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
           },
           {
              "id":"2",
              "type":"game",
              "attributes":{
                 "status":"in_progress",
                 "starting_fen":"rnbqkbnr/pppppppp/8/8/8/8/PPPPPP2/RN1QK2R w KQkq - 0 1",
                 "current_fen":"rnbqkbnr/pppppppp/8/8/8/8/PPPPPP2/RN1QK2R w KQkq - 0 1"
              },
              "relationships":{
                 "quest":{
                    "data":{
                       "id":"1",
                       "type":"quest"
                    }
                 }
              }
           },
           {
              "id":"3",
              "type":"game",
              "attributes":{
                 "status":"in_progress",
                 "starting_fen":"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
                 "current_fen":"r1bqkbnr/ppppppp1/n6p/4P3/8/8/PPPP1PPP/RNBQKBNR w KQkq - 1 3"
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
        ]
     }
      @quest = Quest.new(@data[:data])
    end

    it 'has attributes' do
      expect(@quest.id).to eq(@data[:data][:id])
      expect(@quest.status).to eq(@data[:data][:attributes][:status])
      expect(@quest.name).to be_a String
    end
  end
end
