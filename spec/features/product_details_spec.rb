require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They click on Details link and reach product details page" do

    visit root_path
    first("article.product").click_on "Details"

    # DEBUG / VERIFY
    save_screenshot

    expect(page).to have_css 'article.product-detail'
  end

  scenario "They click on product image and reach product details page" do

    visit root_path
    first("article.product").find("img").click

    # DEBUG / VERIFY
    save_screenshot

    expect(page).to have_css 'article.product-detail'
  end

end
