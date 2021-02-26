require 'rails_helper'

RSpec.describe 'Dashboard Show Page', type: :feature do
  describe '' do
    before :each do
      stub_omniauth
      @user = User.create(email: 'john@example.com', uid: '100000000000000000000')
      visit root_path
      click_link 'Sign In With Google'
    end

    xit 'displays button to create new quest if no quest is ongoing' do
      # Feature test for when new quest button actually works!
      expect(page).to have_button('Start Quest')
      expect(page).to_not have_css('.current-quest')

      click_button 'Start Quest'


      expect(current_path).to eq(users_dashboard_path(@user))
      expect(page).to_not have_button('Start Quest')
      expect(page).to have_css('.current-quest')
      expect(page).to have_button('Start Game')
    end
  end
end
