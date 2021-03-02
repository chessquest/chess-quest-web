require 'rails_helper'

RSpec.describe 'Dashboard Show Page', type: :feature do
  describe '' do
    before :each do
      User.destroy_all
      WebMock.allow_net_connect!
      VCR.turn_off!
      stub_omniauth
      @user = User.create!(email: 'john@example.com', uid: '100000000000000000000')
      visit root_path
      click_link 'Sign In With Google'
    end

    it 'displays button to create new quest if no quest is ongoing' do
      # stub_get_json("https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=in_progress", 'no_quests.json')
      # stub_get_json("https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=completed", 'no_quests.json')
      visit dashboard_path

      # click_link 'Sign In With Google'

      expect(page).to have_button('Start Quest')
      expect(page).to_not have_css('.current-quest')
    end

    it "displays current quest if one is ongoing" do
      # stub_get_json("https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=in_progress", 'quest.json')

      visit dashboard_path

      # stub_get_json("https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=completed", 'completed_quests.json')

      # click_link 'Sign In With Google'

      click_button "Start Quest"

      expect(current_path).to eq(dashboard_path)

      expect(page).to_not have_button('Start Quest')
      expect(page).to have_css('.current-quest')
      expect(page).to have_button('Start Game')
    end

    it "allows you to create a new quest" do
      # stub_get_json("https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=in_progress", 'no_quests.json')

      visit dashboard_path


      # stub_get_json("https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=completed", 'no_quests.json')

      # click_link 'Sign In With Google'

      # json_response = File.read("./spec/fixtures/quest.json")
      # stub_request(:post, "https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests").
      #   to_return(status: 200, body: json_response)

      # stub_get_json("https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=in_progress", 'quest.json')

      click_button 'Start Quest'

      expect(current_path).to eq(dashboard_path)
      expect(page).to_not have_button('Start Quest')
      expect(page).to have_css('.current-quest')
      expect(page).to have_button('Start Game')
    end

    it 'allows you to create a new game' do
      # stub_get_json("https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=in_progress", 'quest.json')
      visit dashboard_path

      # stub_get_json("https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=completed", 'completed_quests.json')

      # json_response = File.read("./spec/fixtures/game.json")
      #
      # stub_request(:post, "https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/games?find_player=magnuscarlsen").
      #   to_return(status: 200, body: json_response)

      # stub_get_json("https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/games/1", "game.json")

      # click_link 'Sign In With Google'

      click_button "Start Quest"

      click_button 'Start Game'

      expect(page).to have_css('#myBoard')
      expect(page).to have_content("Good Luck!")
      expect(current_path.match?(/\/\d+/)).to eq(true)
    end
  end
end
