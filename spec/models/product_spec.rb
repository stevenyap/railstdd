require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'Validation' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :category }
    it { should validate_numericality_of(:price).is_greater_than(0)}

    it 'should check that title is shorter than description' do
      product = Product.new(title: 'Longer Title', description: 'Shorter', price: 12.99)
      product.validate
      expect(product.errors.messages).to include(title: ["should be shorter than description"])
    end
  end
  
  context 'Association' do
    it { should belong_to :category }
  end
end