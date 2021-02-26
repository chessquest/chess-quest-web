require 'rails_helper'

RSpec.describe 'Quest Request' do
  describe 'Quest Create' do
    before :each do
      stub_omniauth
      @user = User.create(email: 'john@example.com', uid: '100000000000000000000')
    end

    describe 'Happy Path' do
      it 'it creates a quest in the backend and receives a response object' do
        json_response = File.read("spec/fixtures/quest.json")
        stub_request(:post, "https://chess-quest-api.herokuapp.com/api/v1/users/:user_id/quests").
          to_return(status: 200, body: json_response)
        
        parsed_response = JSON.parse(json_response, symbolize_names: true)
        
        # expect(response).to be_successful
        # expect(response.status).to eq(201)
        
        expect(parsed_response).to be_a Hash
        expect(parsed_response[:data][:attributes][:status]).to eq('in_progress')
        expect(parsed_response[:data][:attributes][:user_id]).to eq('12')
        expect(parsed_response[:data][:attributes][:name]).to eq('Orcs on the Run')
      end
    end
  end
end
