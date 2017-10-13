class ReviewsController < ApplicationController
  def new
  end

  def show
    @review = Review.find_by(product_id: params[:id])
    @user = User.find_by(user_id: @review.user_id)
  end

  def create
  end
end
