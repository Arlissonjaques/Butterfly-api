# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products', type: :request do
  before do
    @user = create(:user)
    @login_url = '/api/auth/sign_in'
    @login_params = {
      email: @user.email,
      password: @user.password
    }
  end

  # index
  it 'get all products' do
    get '/api/v1/products'
    expect(response).to have_http_status(200)
  end

  # show
  context 'show product' do
    let!(:product) { create(:product) }

    it 'with existing product' do
      get "/api/v1/products/#{product.id}"
      expect(response).to have_http_status(200)
    end

    it 'with non-existent product' do
      get '/api/v1/products/-1'
      expect(response).to have_http_status(404)
    end
  end

  # create
  describe 'creating product' do
    before { post @login_url, params: @login_params }
    let!(:p) { create(:product) }

    context 'with authentication' do
      it 'with correct parameters' do
        params = { name: p.name, color: p.color, description: p.description, category_id: p.category_id }
        post '/api/v1/products', params: params, headers: headers
        expect(response).to have_http_status(201)
      end

      it 'with invalid parameters' do
        post '/api/v1/products', params: {}, headers: headers
        expect(response).to have_http_status(422)
      end
    end

    context 'no authentication' do
      it 'with correct parameters' do
        params = { name: p.name, color: p.color, description: p.description, category_id: p.category_id }
        post '/api/v1/products', params: params
        expect(response).to have_http_status(401)
      end

      it 'with invalid parameters' do
        post '/api/v1/products', params: {}
        expect(response).to have_http_status(401)
      end
    end
  end

  # update
  describe 'updating product' do
    context 'with authentication' do
      before { post @login_url, params: @login_params }
      let!(:product) { create(:product) }

      it 'with correct params' do
        put "/api/v1/products/#{product.id}", params: { "name": build(:product).name }, headers: headers
        expect(response).to have_http_status(200)
      end

      it 'with invalid params' do
        put "/api/v1/products/#{product.id}", params: { name: '' }, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'with empty parameters' do
        put "/api/v1/products/#{product.id}", params: {}, headers: headers
        expect(response).to have_http_status(200)
      end
    end

    context 'no authentication' do
      let!(:product) { create(:product) }

      it 'with correct params' do
        put "/api/v1/products/#{product.id}", params: { "name": build(:product).name }
        expect(response).to have_http_status(401)
      end

      it 'with invalid params' do
        put "/api/v1/products/#{product.id}", params: { "name": '' }
        expect(response).to have_http_status(401)
      end

      it 'with empty parameters' do
        put "/api/v1/products/#{product.id}", params: {}
        expect(response).to have_http_status(401)
      end
    end
  end

  # delete
  describe 'excluded product' do
    context 'with authentication' do
      before { post @login_url, params: @login_params }
      let!(:product) { create(:product) }

      it 'existing product' do
        delete "/api/v1/products/#{product.id}", headers: headers
        expect(response).to have_http_status(204)
      end

      it 'non-existent product' do
        delete '/api/v1/products/-1', headers: headers
        expect(response).to have_http_status(404)
      end
    end

    context 'no authentication' do
      let!(:product) { create(:product) }

      it 'existing product' do
        delete "/api/v1/products/#{product.id}"
        expect(response).to have_http_status(401)
      end

      it 'non-existent product' do
        delete '/api/v1/products/-1'
        expect(response).to have_http_status(404)
      end
    end
  end

  # Assists
  def headers
    {
      'uid' => response.headers['uid'],
      'client' => response.headers['client'],
      'access-token' => response.headers['access-token']
    }
  end
end
