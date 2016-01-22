require 'rails_helper'
require 'spec_helper'

describe Restaurant, type: :model do
  let(:professor_X) { User.create(email: "charlesxavier@xmen.com", 
                              password: "istituteForGiftedYougnsters", 
                              password_confirmation: "istituteForGiftedYougnsters") }
  let(:magneto) { User.create(email: "maxeisenhardt@brotherhood.com", 
                              password: "weWillRiseAgain45", 
                              password_confirmation: "weWillRiseAgain45") }

  it { is_expected.to have_many :reviews }
  it { is_expected.to belong_to :user }

  it "is invalid when name has less than three characters" do
    restaurant = Restaurant.new(name: "Na")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it "is invalid when name is not unique" do
    Restaurant.create(name: "Hamid's Tavern")
    restaurant = Restaurant.new(name: "Hamid's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end

  describe '#avarage_rating' do
    context 'no reviews' do
      it "returns 'N/A' when there are no reviews" do
        restaurant = Restaurant.new(name: "Hamid's Tavern")
        expect(restaurant.average_rating).to eq "N/A"
      end
    end

    context 'one review' do
      it "returns corresponding the review" do
        professorsJoint = professor_X.restaurants.create(name: "TheProfessor'sJoint")
        professorsJoint.reviews.create(rating: 5)
        expect(professorsJoint.average_rating).to eq 5
      end
    end

    context 'multiple reviews' do
      it "returns the average ratings" do
        p magneto
        professorsJoint = professor_X.restaurants.create(name: "TheProfessor'sJoint")
        professorsJoint.reviews.create(rating: 5)
        professorsJoint.reviews.new(rating: 1).save(validate: false)
        expect(professorsJoint.average_rating).to eq 3
      end
    end
  end

  # it "can only be deleted by it's creator" do
  #   p professor_X
  #   p magneto
  #   professorsJoint = professor_X.restaurants.create(name: "TheProfessor'sJoint")
  #   magneto.restaurants.delete(professorsJoint)
  #   restaurants = Restaurant.all
  #   # p restaurants
  #   expect(restaurants).to include(professorsJoint)
  # end
end


# fill_in "Email", with: "maxeisenhardt@brotherhood.com"
# fill_in "Password", with: "weWillRiseAgain45"
# fill_in "Password confirmation", with: "weWillRiseAgain45"