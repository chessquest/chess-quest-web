require 'rails_helper'

RSpec.describe 'Dashboard Show Page', type: :feature do
  describe '' do
    before :each do
      stub_omniauth
      @user = User.create(email: 'john@example.com', uid: '100000000000000000000')
      visit root_path
      click_link 'Sign In With Google'
    end

    it 'displays button to create new quest if no quest is ongoing' do
      expect(page).to have_button('Start Quest')
      expect(page).to_not have_css('.current-quest')

      click_button 'Start Quest'

      # expect(response).to be_successful
      # expect(response.status).to eq(201)

      expect(current_path).to eq(users_dashboard_path(@user))
      expect(page).to_not have_button('Start Quest')
      expect(page).to have_css('.current-quest')
      expect(page).to have_button('Start Game')

      # parsed_response = JSON.parse(response.body, symbolize_names: true)
      #   expect(parsed_response).to be_a Hash
      #   expect(parsed_response[:data][:attributes][:status]).to eq('in_progress')
      #   expect(parsed_response[:data][:attributes][:user_id]).to eq(@user.id)
      #   expect(parsed_response[:data][:attributes][:starting_fen]).to eq(created_game.starting_fen)
      #   expect(parsed_response[:data][:attributes][:starting_fen]).to eq(created_game.current_fen)
    end
  end
end
