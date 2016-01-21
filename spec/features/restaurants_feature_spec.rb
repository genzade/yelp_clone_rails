require "rails_helper"

feature "Restaurants" do

  context "users not signed up or logged in" do
    context "can view restaurants but cannot add them" do
      scenario "must be logged in" do
        visit "/restaurants"
        click_link "Add a restaurant"
        expect(page).not_to have_button "Create Restaurant"
        expect(current_path).to eq "/users/sign_in"
      end
    end
  end

  # Users can only edit/delete restaurants which they've created
  # Users can only leave one review per restaurant
  # Users can delete only their own reviews

  context "user signs up and logs in" do
    before { xavier_signs_up }

    context "no restaurants have been added" do
      scenario "should display a prompt to add a restaurant" do
        visit "/restaurants"
        expect(page).to have_content "No restaurants yet!"
        expect(page).to have_link "Add a restaurant"
      end

      context "creating restaurants" do
        before do
          visit "/restaurants"
          click_link "Add a restaurant"
        end

        scenario "ability to add restaurants" do
          expect(current_path).to eq "/restaurants/new"
          fill_in "Name", with: "Nandos"
          click_button "Create Restaurant"
          expect(page).to have_content "Nandos"
          expect(current_path).to eq "/restaurants"
        end

        context "an invalid restaurant" do
          scenario "does not let you submit a name that is too short" do
            fill_in "Name", with: 'Na'
            click_button "Create Restaurant"
            expect(page).not_to have_css "h2", text: "Na"
            expect(page).to have_content "error"
          end
        end
      end
      
      context "lets user delete restaurants" do
        scenario "removes a restaurant when user clicks a delete link" do
          add_nandos
          click_link "Delete Nandos"
          expect(page).not_to have_css "h2", text: "Nandos"
          expect(page).to have_content "Nandos has been deleted"
        end
      end

      context "another user deletes restaurant" do
        scenario "user can only delete a restaurant that they have created" do
          add_nandos
          click_link "Sign out"
          magneto_signs_up
          visit "/"
          click_link "Delete Nandos"
          expect(page).not_to have_content("Nandos has been deleted")
          expect(page).to have_content("You are not permitted to delete Nandos") 
        end
      end

      context "another user edit restaurant" do
        scenario "user can only edit a restaurant that they have created" do
          add_nandos
          click_link "Sign out"
          magneto_signs_up
          click_link "Edit Nandos"
          expect(page).to have_content("You are not permitted to edit Nandos") 
        end
      end
    end

    context "restaurants have been added" do
      let!(:nandos) { Restaurant.create(name: "Nandos") }

      scenario "displays restaurants" do
        visit "/restaurants"
        expect(page).to have_content "Nandos"
        expect(page).not_to have_content "No restaurants yet!"
      end

      context "viewing restaurants" do
        scenario "lets a user view a restaurant" do
          visit "/restaurants"
          click_link "Nandos"
          expect(page).to have_content "Nandos"
          expect(current_path).to eq "/restaurants/#{nandos.id}"
        end

        scenario "lets a user edit a restaurant" do
          visit "/restaurants"
          click_link "Edit Nandos"
          fill_in "Name", with: "Grilled Chicken"
          click_button "Update Restaurant"
          expect(page).to have_content "Grilled Chicken"
          expect(current_path).to eq "/restaurants"
        end
      end


      context "prevents restaurant duplication" do
        scenario "restaurants added must be unique" do
         add_nandos
          expect(page).to have_content "error"
        end
      end
    end
  end
end
