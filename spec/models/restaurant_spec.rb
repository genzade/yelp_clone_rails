require 'rails_helper'

describe Restaurant, type: :model do
  # subject(:restaurant) {  desc}
  # let(:professor_X) { User.create(email: "charlesxavier@xmen.com", 
  #   password: "istituteForGiftedYougnsters", 
  #   password_confirmation: "istituteForGiftedYougnsters") }
  # let(:magneto) { User.create(email: "maxeisenhardt@brotherhood.com", 
  #   password: "weWillRiseAgain45", 
  #   password_confirmation: "weWillRiseAgain45") }

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

  # it "can only be deleted by it's creator" do
  #   p professor_X
  #   p magneto
  #   professorsJoint = professor_X.restaurants.create(name: "TheProfessor'sJoint")
  #   p professorsJoint
  #   magneto.restaurants.delete(professorsJoint)
  #   restaurants = Restaurant.all
  #   # p restaurants
  #   expect(restaurants).to include(professorsJoint)
  # end
end


# fill_in "Email", with: "maxeisenhardt@brotherhood.com"
# fill_in "Password", with: "weWillRiseAgain45"
# fill_in "Password confirmation", with: "weWillRiseAgain45"