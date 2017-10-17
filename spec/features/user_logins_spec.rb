require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
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

  scenario "User signs in with credentials" do
    user = User.create!({
        first_name: 'Bruce',
        last_name: 'Wayne',
        email: 'notbatman@batman.com',
        password: '12345678',
        password_confirmation: '12345678'
    })

    visit root_path

    click_on "Login"

    save_screenshot

    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_on "Submit"

    # Should redirect to home page, with the User's first name in the navbar
    expect(page).to have_css 'article.product', count: 10
    expect(page.find("ul.navbar-right")).to have_content user[:first_name]

  end

end
