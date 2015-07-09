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

  describe '#show' do
    let!(:product) { create(:product) }

    it 'should find a product for view' do
      get :show, id: product.id
      expect(assigns(:product)).to eq product
    end
  end

  describe '#new' do
    it 'should instantiate a product for view' do
      get :new
      expect(assigns(:product)).to be_a Product
    end
  end

  describe '#create' do
    def do_request
      post :create, params
    end

    context 'Success' do
      let!(:category) { create(:category) }
      let!(:params)   { { product: attributes_for(:product, category_id: category.id) } } 

      it 'should save a product' do
        expect { do_request }.to change(Product, :count).by(1)
      end

      it 'should redirect to products listing' do
        expect(do_request).to redirect_to products_url
      end
    end

    context 'Failure' do
      let!(:params)   { { product: attributes_for(:product, title: '') } }

      it 'should not save the product' do
        expect { do_request }.not_to change(Product, :count)
      end

      it 'should render :new template' do
        expect(do_request).to render_template :new
      end
    end
  end

  describe '#edit' do
    def do_request
      get :edit, id: product.id
    end

    let!(:product) { create(:product) }

    it 'should render the new template' do
      expect(do_request).to render_template :new
    end

    it 'should find the product to edit' do
      do_request
      expect(assigns(:product)).to eq product
    end
  end

  describe '#update' do
    def do_request
      put :update, id: product.id, product: updated_params
    end

    let!(:product)        { create(:product, title: 'Ruby Book') }
    let!(:updated_params) { attributes_for(:product, title: new_title) }

    context 'Success' do    
      let!(:new_title) { 'Python Book' }
      
      it 'should update the product' do
        do_request
        expect(assigns(:product).title).to eq new_title
      end
    end

    context 'Failure' do      
      let!(:new_title) { '' }
      
      it 'should not update the product' do
        do_request
        expect(product.reload.title).to eq 'Ruby Book'
      end

      it 'should render :new template' do
        expect(do_request).to render_template :new
      end
    end
  end

  describe '#destroy' do
    let!(:product) { create(:product) }

    it 'should destroy a product' do
      expect {
        delete :destroy, id: product.id
      }.to change(Product, :count).by(-1)
    end
  end
end