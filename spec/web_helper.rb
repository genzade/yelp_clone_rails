def xavier_signs_up
  visit "/"
  click_link "Sign up"
  fill_in "Email", with: "charlesxavier@xmen.com"
  fill_in "Password", with: "istituteForGiftedYougnsters"
  fill_in "Password confirmation", with: "istituteForGiftedYougnsters"
  click_button "Sign up"
end

def magneto_signs_up
  visit "/"
  click_link "Sign up"
  fill_in "Email", with: "maxeisenhardt@brotherhood.com"
  fill_in "Password", with: "weWillRiseAgain45"
  fill_in "Password confirmation", with: "weWillRiseAgain45"
  click_button "Sign up"
end

def add_nandos
  visit "/restaurants"
  click_link "Add a restaurant"
  fill_in "Name", with: "Nandos"
  click_button "Create Restaurant"
end

def add_review_first
  visit "/restaurants"
  click_link "Review Nandos"
  fill_in "Opinion", with: "I don't even like chicken"
  select "3", from: "Rating"
  click_button "Leave Review"
end

def add_review_again
  visit "/restaurants"
  click_link "Review Nandos"
  fill_in "Opinion", with: "I do actually like chicken"
  select "5", from: "Rating"
  click_button "Leave Review"
end

def leave_review
end