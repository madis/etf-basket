require 'rails_helper'

RSpec.feature 'User creates portfolio' do
  scenario 'with valid input' do
    visit portfolios_path
    click_link 'New'
    fill_in 'Name', with: 'Joe invests'
    click_button 'Create'
    expect(page).to have_content 'Portfolio was successfully created'
    expect(page).to have_content 'Joe invests'
  end
end
