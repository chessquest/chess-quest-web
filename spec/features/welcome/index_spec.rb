require 'rails_helper'

describe 'Welcome Index', type: :feature do
  before :each do
    allow(QuestsFacade).to receive(:get_current_quest).and_return([])
    allow(QuestsFacade).to receive(:get_completed_quests).and_return([])
    allow(QuestsFacade).to receive(:get_current_win_streak).and_return([])
    allow(QuestsFacade).to receive(:get_current_game).and_return([])
    allow(QuestsFacade).to receive(:get_won_games).and_return([])
    allow(GamesFacade).to receive(:get_top_3_quest_streak).and_return([])
  end
  
  it 'when I visit the root path I see a description and a link to sign in with Google' do
    visit root_path
    
    expect(page).to have_content('Welcome')
    expect(page).to have_content('Sign In With Google')
    expect(page).to have_css('.description')
  end

  it 'logs the user in via google mock' do
    user_count = User.count
    expect(user_count).to eq(0)

    stub_omniauth
    user = User.create(email: 'john@example.com', uid: '100000000000000000000')

    visit root_path
    click_link 'Sign In With Google'

    user_count = User.count
    expect(user_count).to eq(1)
    user = User.first

    expect(page).to have_content("Welcome to Chess Quest, #{user.email}")
  end

  it 'logs a returning user in via google mock' do
    stub_omniauth
    user = User.create(email: 'john@example.com', uid: '100000000000000000000')
    user_count = User.count
    expect(user_count).to eq(1)

    visit root_path

    click_link 'Sign In With Google'

    user_count = User.count
    expect(user_count).to eq(1)

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Welcome to Chess Quest, #{user.email}")
  end
end
