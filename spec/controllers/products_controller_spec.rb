require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe '#index' do
    context 'Listing of products' do
      let!(:products) { create_list(:product, 2) }    

      it 'should have a list of products' do
        get :index
        expect(assigns(:products).length).to eq 2
      end
    end

    context 'Display Published Products' do
      let!(:unpublished_product) { create(:product, published: false) }
      let!(:published_product)   { create(:product, published: true) }
      let(:assigned_products)    { assigns(:products) }
     
      it 'should only display published products' do
        get :index
        expect(assigned_products).to include published_product
        expect(assigned_products).not_to include unpublished_product
      end
    end
  end
end