require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe '#index' do
    let!(:products) { FactoryGirl.create_list(:product, 2) }    

    it 'should have a list of products' do
      get :index
      expect(assigns(:products).length).to eq 2
    end
  end
end