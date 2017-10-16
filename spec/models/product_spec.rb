require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:category) }

    it "create new product with valid attributes" do
      @cat = Category.find_or_create_by! name: 'Apparel'
      @cat.products.create!({
        name: 'MegaMarker',
        price: 13.13,
        quantity: 32,
        })
      expect(Product.count).to eq(1)
    end

    it "fails to create new product with missing name" do
      @cat = Category.find_or_create_by! name: 'Apparel'
      @cat.products.create({
        name: '',
        price: 13.13,
        quantity: 32,
        }).should_not be_valid
    end

    it "fails to create new product with missing price" do
      @cat = Category.find_or_create_by! name: 'Apparel'
      @cat.products.create({
        name: 'MegaMarker',
        quantity: 32,
        }).should_not be_valid
    end

    it "fails to create new product with missing quantity" do
      @cat = Category.find_or_create_by! name: 'Apparel'
      @cat.products.create({
        name: 'MegaMarker',
        price: 13.13,
        }).should_not be_valid
    end

    it "fails to create new product with missing quantity" do
      @cat = Category.find_or_create_by! name: 'Apparel'
      Product.create({
        name: 'MegaMarker',
        price: 13.13,
        quantity: 26,
        }).should_not be_valid
    end
  end
end
