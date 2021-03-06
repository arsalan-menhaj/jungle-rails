class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    @average_rating = @product.reviews.average(:rating).to_f.round(1).to_s
    @review = current_user ? @product.reviews.find_by(user_id: current_user.id) : nil
  end

end
