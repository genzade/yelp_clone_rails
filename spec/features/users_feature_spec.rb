require "rails_helper"

feature "User can singn in and out" do
  context "user not signed in and on the homepage" do
    scenario "should see links to 'sign in' and 'sign up'" do
      visit "/"
      expect(page).to have_link("Sign in")
      expect(page).to have_link("Sign up")
    end

    scenario "should not see 'sign out' link" do
      visit "/"
      expect(page).not_to have_link("Sign out")
    end
  end

  context "user signed in and on the hopepage" do
    before do
      visit "/"
      click_link "Sign up"
      fill_in "Email", with: "xavier@xmen.com"
      fill_in "Password", with: "istituteForGiftedYougnsters"
      fill_in "Password confirmation", with: "istituteForGiftedYougnsters"
      click_button "Sign up"
    end

    scenario "should see 'sign out' link" do
      visit "/"
      expect(page).to have_link("Sign out")
    end

    scenario "should not see links to 'sign in' and 'sign up'" do
      visit "/"
      expect(page).not_to have_link("Sign in")
      expect(page).not_to have_link("Sign up")   
    end
  end
end