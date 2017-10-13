class ReviewsController < ApplicationController
  def new
  end

  def show
    @product = Product.find(params[:product_id])
    @reviews = @product.reviews
  end

  def create
    puts review_params
    puts session[:user_id]
    @review_data = review_params
    review = Review.new({
      product_id: @review_data[:product_id],
      user_id: session[:user_id],
      description: @review_data[:description],
      rating: @review_data[:rating]
    })
    puts review.save
    if review.save
      redirect_to ('/products/' + @review_data[:product_id].to_s)
    else
      redirect_to '/'
    end
  end

  def destroy
    @review = Review.find_by(id: params[:id])

    if @review.destroy
      redirect_to ('/products/' + params[:product_id].to_s)
    else
      redirect_to '/'
    end
  end

  private
    def review_params
      params.require(:review).permit(:description, :rating, :product_id)
    end
end
