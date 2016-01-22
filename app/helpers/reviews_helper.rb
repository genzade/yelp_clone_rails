module ReviewsHelper
  def star_rating(rating)
    return rating unless rating.is_a?(Fixnum) || rating.is_a?(Float)
    remainder = (5 - rating)
    "★" * rating.round + "☆" * remainder
  end
end
