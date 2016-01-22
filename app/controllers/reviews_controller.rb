class ReviewsController < ApplicationController
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new(review_params)

    unless @review.save
      flash[:notice]= "You are not permitted to review #{@restaurant.name} again"
    end
  
    redirect_to restaurants_path
  end

  def review_params
    new_params = params.require(:review).permit(:opinion, :rating)
    new_params[:user_id] = current_user.id
    new_params
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.user_id == current_user.id
      @review.destroy
      flash[:notice]= "review has been deleted"
    else
      flash[:notice]= "You are not permitted to delete review"
    end

    redirect_to restaurants_path
  end
end
