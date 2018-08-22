require 'rails_helper'

RSpec.feature 'User adds ETF to their portfolio' do
  scenario 'with valid input' do
    portfolio = create(:portfolio)
    etf1 = create(:etf_with_constituents, name: 'First', symbol: 'FST')
    etf2 = create(:etf_with_constituents, name: 'Second', symbol: 'SND')

    visit edit_portfolio_path(portfolio)
    select 'First'
    select 'Second'
    click_button 'Update'
    expect(page).to have_content 'Portfolio was successfully updated'
    expect(page).to have_content 'FST'
    expect(page).to have_content 'Second'
  end
end
