require "rails_helper"

feature "endorsing reviews" do
  before { xavier_signs_up ; add_nandos }

  scenario "displays the number of endorsements per review" do
    add_review_first
    expect(page).to have_content "0 endorsements"
  end

  scenario 'a user can endorse a review, which updates the review endorsement count' do
    visit '/restaurants'
    add_review_first
    click_link 'Endorse review'
    expect(page).to have_content('1 endorsement')
  end
end