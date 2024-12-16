require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    let(:category) { Category.create(name: 'Test Category') }

    context 'when all fields are provided and valid' do
      it 'is valid' do
        product = Product.new(
          name: 'Sample Product',
          price_cents: 1000,
          quantity: 10,
          category: category
        )
        expect(product).to be_valid
      end
    end

    context 'when a field is missing' do
      it 'is not valid without a name' do
        product = Product.new(
          name: nil,
          price_cents: 1000,
          quantity: 10,
          category: category
        )
        expect(product).to_not be_valid
        expect(product.errors[:name]).to include("can't be blank")
      end

      it 'is not valid without a price' do
        product = Product.new(
          name: 'Sample Product',
          price_cents: nil,
          quantity: 10,
          category: category
        )
        expect(product).to_not be_valid
        expect(product.errors[:price_cents]).to include("is not a number")
      end

      it 'is not valid without a quantity' do
        product = Product.new(
          name: 'Sample Product',
          price_cents: 1000,
          quantity: nil,
          category: category
        )
        expect(product).to_not be_valid
        expect(product.errors[:quantity]).to include("can't be blank")
      end

      it 'is not valid without a category' do
        product = Product.new(
          name: 'Sample Product',
          price_cents: 1000,
          quantity: 10,
          category: nil
        )
        expect(product).to_not be_valid
        expect(product.errors[:category]).to include("can't be blank")
      end
    end
  end
end