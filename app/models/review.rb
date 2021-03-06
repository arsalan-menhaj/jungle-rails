class Review < ActiveRecord::Base
  belongs_to :product

  validates :product_id, presence: true
  validates :user_id, presence: true
  validates :description, presence: true
  validates :rating, presence: true,
                     numericality: {
                        greater_than_or_equal_to: 0,
                        less_than_or_equal_to: 5
                      }
end
