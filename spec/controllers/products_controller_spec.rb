require 'rails_helper'
require_relative '../support/auth_helper'

#Passing tests with authentication details
describe ProductsController, type: :controller do
  render_views

  # login to http basic auth
  include AuthHelper
  before(:each) do
    http_login
  end

  describe 'GET #admin' do
    it "renders the :admin template" do
      get :admin
      expect(response).to render_template :admin
    end

  end

   describe 'GET #new' do
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "assigns the requested product to @product" do
      test = Product.create(title:'test')
      get :edit, id: test
      expect(assigns(:product)).to eq test
    end
    it "renders the :edit template" do
      test = Product.create(title:'test')
      get :edit, id: test
      expect(assigns(:product)).to render_template :edit
    end
  end

    describe "POST #create" do
    it "saves the new product in the database" do
      tests = Product.all
      expect{
        post :create, product: {title: 'test'}
        }.to change(tests, :count).by(1)
      end
      it "redirects to products#admin" do
        post :create, product: {title: 'test'}
        expect(response).to redirect_to admin_path
      end

      context "with invalid attributes" do
        it "does not save the new product in the database" do
          tests = Product.all
          expect{
            post :create, product: { name: 'bad test'}
            }.not_to change(tests, :count)
          end
          it "re-renders the :new template" do
            post :create, product: {name: 'bad test'}
            expect(response).to render_template :new
          end
        end
      end

      describe 'PATCH #update' do
    before :each do
      @product = Product.create(title: 'test1')
    end

    context "with valid attributes" do
      it "updates the product in the database" do
        patch :update, id: @product,
        product: { title: 'test2'}
        @product.reload
        expect(@product.title).to eq('test2')
      end
      it "redirects to the product" do
        patch :update, id: @product,
        product: { title: 'test2'}
        expect(response).to redirect_to admin_path
      end
    end

    context "with invalid attributes" do
      it "does not update the product" do
        patch :update, id: @product,
        product: { title: nil}
        @product.reload
        expect(@product.title).not_to eq('bad test')
      end
      it "re-renders the :edit template" do
        patch :update, id: @product,
        product: { title: nil}
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @product = Product.create(title: 'test1')
    end
    it "deletes the product from the database" do
      tests = Product.all
      expect{
        delete :destroy, id: @product
        }.to change(tests,:count).by(-1)
      end
      it "redirects to users#index" do
        delete :destroy, id: @product
        expect(response).to redirect_to products_url
      end
  end

end

describe ProductsController, type: :controller do


  describe 'GET #index' do
    context 'without params[:letter]' do
      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    it "assigns the requested product to @product" do
      test = Product.create(title:'test')
      get :show, id: test
      expect(assigns(:product)).to eq test
    end
    it "renders the :show template" do
      test = Product.create(title:'test')
      get :show, id: test
      expect(response).to render_template :show
    end
  end

end


describe ProductsController, type: :controller do
  render_views

  # login to http basic auth
  include AuthHelper
  before(:each) do
    http_login_fail
  end

  describe 'GET #admin ' do
    it "fails to render the :admin template without authentication" do
      get :admin
      expect(response).not_to render_template :admin
    end
  end

  describe 'GET #new' do
    it "renders the :new template" do
      get :new
      expect(response).not_to render_template :new
    end
  end

  describe 'GET #edit' do
    it "renders the :edit template" do
      test = Product.create(title:'test')
      get :edit, id: test
      expect(assigns(:product)).not_to render_template :edit
    end
  end

end