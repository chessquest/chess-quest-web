require 'rails_helper'

RSpec.describe 'Dashboard Show Page', type: :feature do
  describe 'as a user' do
    before :each do
      stub_omniauth
      @user = User.create(email: 'john@example.com', uid: '100000000000000000000')

        json_response = File.read("./spec/fixtures/top3_game_stat.json")
      stub_request(:get, "https://chess-quest-api.herokuapp.com/api/v1/top_quests").
        to_return(status: 200, body: json_response)

      json_response = File.read("./spec/fixtures/user_top_streak.json")
      # parsed_response = JSON.parse(json_response)
      stub_request(:get, "https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/win_streak").
        to_return(status: 200, body: json_response)
    end

    it 'displays button to create new quest if no quest is ongoing' do
      json_response = File.read("./spec/fixtures/no_quests.json")
      stub_request(:get, "https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=in_progress").
        to_return(status: 200, body: json_response)

      json_response = File.read("./spec/fixtures/completed_quests.json")
      stub_request(:get, "https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=completed").
        to_return(status: 200, body: json_response)

      visit root_path

      click_link 'Sign In With Google'

      expect(page).to have_button('Start Quest')
      expect(page).to_not have_css('.current-quest')
    end

    it "displays current quest if one is ongoing" do
      json_response = File.read("./spec/fixtures/quest.json")
      stub_request(:get, "https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=in_progress").
        to_return(status: 200, body: json_response)
      visit root_path

      json_response = File.read("./spec/fixtures/completed_quests.json")
      stub_request(:get, "https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=completed").
        to_return(status: 200, body: json_response)

      click_link 'Sign In With Google'

      expect(current_path).to eq(dashboard_path)
      expect(page).to_not have_button('Start Quest')
      expect(page).to have_css('.current-quest')
      expect(page).to have_button('Start Game')
    end

    it "allows you to create a new quest" do
      json_response = File.read("./spec/fixtures/no_quests.json")
      stub_request(:get, "https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=in_progress").
        to_return(status: 200, body: json_response)
      visit root_path

      json_response = File.read("./spec/fixtures/no_quests.json")
      stub_request(:get, "https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=completed").
        to_return(status: 200, body: json_response)

      click_link 'Sign In With Google'

      json_response = File.read("./spec/fixtures/quest.json")
      stub_request(:post, "https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests").
        to_return(status: 200, body: json_response)
      stub_request(:get, "https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=in_progress").
        to_return(status: 200, body: json_response)
      
      click_button 'Start Quest'

      expect(current_path).to eq(dashboard_path)
      expect(page).to_not have_button('Start Quest')
      expect(page).to have_css('.current-quest')
      expect(page).to have_button('Start Game')
    end

    it 'allows you to create a new game' do
      json_response = File.read("./spec/fixtures/quest.json")
      stub_request(:get, "https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=in_progress").
        to_return(status: 200, body: json_response)
      visit root_path

      json_response = File.read("./spec/fixtures/completed_quests.json")
      stub_request(:get, "https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=completed").
        to_return(status: 200, body: json_response)

      click_link 'Sign In With Google'

      json_response = File.read("./spec/fixtures/game.json")

      stub_request(:post, "https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/games?find_player=magnuscarlsen").
        to_return(status: 200, body: json_response)

      stub_request(:get, "https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/games/1").
        to_return(status: 200, body: json_response)

      click_button 'Start Game'

      expect(page).to have_css('#myBoard')
      expect(page).to have_content("Good Luck!")
      expect(current_path.match?(/\/\d+/)).to eq(true)
    end

    it 'I can see my user and game stats' do
      # When I visit my dashboard (/dashboard),
      json_response = File.read("./spec/fixtures/quest.json")
      stub_request(:get, "https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=in_progress").
        to_return(status: 200, body: json_response)

      json_response = File.read("./spec/fixtures/no_quests.json")
      stub_request(:get, "https://chess-quest-api.herokuapp.com/api/v1/users/#{@user.id}/quests?status=completed").
        to_return(status: 200, body: json_response)
      
      visit root_path
       
      click_link 'Sign In With Google'
        
      visit dashboard_path

      within '#stats' do
        expect(page).to have_content("Current Quest Win Streak:\n2")
        within '#top-win-streak' do
        expect(page).to have_content("6")
        expect(page).to have_content("4")
        expect(page).to have_content("2")
        end
      end
    end
  end
end
