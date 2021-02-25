require 'rails_helper'

describe 'the app is up' do
  it 'when I visit root' do
    visit root_path

    expect(page).to have_content('chess')
  end
end