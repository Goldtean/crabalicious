require 'rails_helper'

# model tests
RSpec.describe Product, :type => :model do
  let(:new_product) { Product.create }
  describe 'validations' do
    it "fails validation with no title" do
      expect(new_product.errors[:title]).to include("can't be blank")
    end
  end
  it "returns a product title as string" do
    product = Product.new(title: 'test1')
    expect(product.title).to eq 'test1'
  end
end
