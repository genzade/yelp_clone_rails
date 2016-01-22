require "rails_helper"

feature "endorsing reviews" do
  before { xavier_signs_up ; add_nandos ; add_review_first }

  scenario "displays the number of endorsements per review" do
    expect(page).to have_content "0 endorsements"
  end

  scenario "a user can endorse a review, which updates the review endorsement count" do
    visit "/restaurants"
    click_link "Endorse review"
    expect(page).to have_content("1 endorsement")
  end

  it "a user can endorse a review, which increments the endorsement count", js: true do
    visit "/restaurants"
    click_link "Endorse review"
    expect(page).to have_content("1 endorsement")
  end
end