require 'rails_helper'

RSpec.describe 'Dashboard Show Page', type: :feature do
  describe '' do
    before :each do
      stub_omniauth
      @user = User.create(email: 'john@example.com', uid: '100000000000000000000')
      # login_as(@user)
    end

    it 'displays button to create new quest if no quest is ongoing' do
      stub_get_json("https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=in_progress", 'no_quests.json')
      stub_get_json("https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=completed", 'no_quests.json')

      visit root_path

      click_link 'Sign In With Google'

      expect(page).to have_button('Start Quest')
      expect(page).to_not have_css('.current-quest')
    end

    it "displays current quest if one is ongoing" do
      stub_get_json("https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=in_progress", 'quest.json')

      visit root_path

      stub_get_json("https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=completed", 'completed_quests.json')

      click_link 'Sign In With Google'

      expect(current_path).to eq(dashboard_path)
      expect(page).to_not have_button('Start Quest')
      expect(page).to have_css('.current-quest')
      expect(page).to have_button('Start Game')
    end

    it "allows you to create a new quest" do
      stub_get_json("https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=in_progress", 'no_quests.json')

      visit root_path

      stub_get_json("https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=completed", 'no_quests.json')

      click_link 'Sign In With Google'

      json_response = File.read("./spec/fixtures/quest.json")
      stub_request(:post, "https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests").
        to_return(status: 200, body: json_response)

      stub_get_json("https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=in_progress", 'quest.json')

      
      click_button 'Start Quest'

      expect(current_path).to eq(dashboard_path)
      expect(page).to_not have_button('Start Quest')
      expect(page).to have_css('.current-quest')
      expect(page).to have_button('Start Game')
    end

    # it 'allows you to create a new game' do
    #   stub_get_json("https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=in_progress", 'quest.json')
    #   visit root_path
    #
    #   stub_get_json("https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=completed", 'completed_quests.json')
    #
    #   click_link 'Sign In With Google'
    #
    #   json_response = File.read("./spec/fixtures/game.json")
    #
    #   stub_request(:post, "https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/games?find_player=magnuscarlsen").
    #     to_return(status: 200, body: json_response)
    #
    #   stub_get_json("https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/games/1", "game.json")
    #
    #   click_button 'Start Game'
    #
    #   # expect(current_path).to eq(gameplay_path(current_game)
    # end
  end
end
