require "rails_helper"

feature "reviewing" do
  before { xavier_signs_up ; add_nandos }

  scenario "allows users to leave a review" do
    add_review_first

    expect(current_path).to eq "/restaurants"
    expect(page).to have_content "I don't even like chicken"
  end

  scenario "delete only review they have created" do
    add_review_first
    expect(page).to have_content "I don't even like chicken"
    click_link "Delete review"
    expect(page).not_to have_content "I don't even like chicken"
    add_review_again
    click_link "Sign out"
    magneto_signs_up
    click_link "Delete review"
    expect(page).to have_content "You are not permitted to delete review"
  end
end
