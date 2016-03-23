require 'rails_helper'

# model tests
RSpec.describe Product, :type => :model do
  let(:new_product) { Product.create }
  let(:new_product2) { Product.new(title: 'test1', price: 2.0, stock: 2)}
  let(:new_product3) { Product.new(title: 'test1', price: 2, stock: 2.5)}


  describe 'validations' do
    it "fails validation with no title" do
      expect(new_product.errors[:title]).to include("can't be blank")
    end
  end

  it "returns a product title as string" do
    expect(new_product2.title).to eq 'test1'
  end

  it "returns product price as float" do
    expect(new_product2.price).to eq 2.0
  end

  it "returns product price as float" do
    expect(new_product3.price).to eq 2.0
  end

  it "returns product stock as integer " do
    expect(new_product2.stock).to eq 2
  end

  it "returns product stock as integer " do
    expect(new_product3.stock).to eq 2
  end
end
