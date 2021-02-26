require 'rails_helper'

describe 'Welcome Index', type: :feature do
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
    user_count = User.count
    expect(user_count).to eq(0)
    
    visit root_path

    uri_template = Addressable::Template.new("https://chess-quest-api.herokuapp.com/api/v1/users/{id}/quests?status=in_progress")
    stub_request(:get, uri_template).
    to_return(status: 200, body: "")
    
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
    stub_request(:get, "https://chess-quest-api.herokuapp.com/api/v1/users/#{User.first.id}/quests?status=in_progress").
    to_return(status: 200, body: "")
    visit root_path

    click_link 'Sign In With Google'

    user_count = User.count
    expect(user_count).to eq(1)

    expect(current_path).to eq(users_dashboard_path(user))
    expect(page).to have_content("Welcome to Chess Quest, #{user.email}")
  end
end
