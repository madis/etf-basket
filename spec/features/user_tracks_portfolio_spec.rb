require 'rails_helper'

RSpec.feature 'User tracks ETF' do
  scenario 'buying stocks into it' do
    portfolio = create(:portfolio, name: 'Money Machine')

    etf = create(:three_part_etf, name: 'X3')
    tracking = Tracking.create(etf: etf, portfolio: portfolio)

    visit edit_tracking_path(tracking)
    expect(page).to have_content "X3 in Money Machine"
  end
end
