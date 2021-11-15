# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products', type: :request do
  # index
  it 'get all products' do
    get api_v1_products_path
    expect(response).to have_http_status(200)
  end

  # show
  context 'show product' do
    let!(:product) { create(:product) }

    it 'with existing product' do
      get api_v1_product_path(product.id)
      expect(response).to have_http_status(200)
    end

    it 'with non-existent product' do
      get api_v1_product_path(-1)
      expect(response).to have_http_status(404)
    end
  end

  # create
  describe 'creating product' do
    let!(:p) { create(:product) }

    context 'with authentication' do
      it 'with correct parameters' do
        params = { name: p.name, color: p.color, description: p.description, category_id: p.category_id }
        post api_v1_products_path, params: params, headers: authentication_headers
        expect(response).to have_http_status(201)
      end

      it 'with invalid parameters' do
        post api_v1_products_path, params: {}, headers: authentication_headers
        expect(response).to have_http_status(422)
      end
    end

    context 'no authentication' do
      it 'with correct parameters' do
        params = { name: p.name, color: p.color, description: p.description, category_id: p.category_id }
        post api_v1_products_path, params: params
        expect(response).to have_http_status(401)
      end

      it 'with invalid parameters' do
        post api_v1_products_path, params: {}
        expect(response).to have_http_status(401)
      end
    end
  end

  # update
  describe 'updating product' do
    context 'with authentication' do
      let!(:product) { create(:product) }

      it 'with correct params' do
        put api_v1_product_path(product.id), params: { "name": build(:product).name }, headers: authentication_headers
        expect(response).to have_http_status(200)
      end

      it 'with invalid params' do
        put api_v1_product_path(product.id), params: { name: '' }, headers: authentication_headers
        expect(response).to have_http_status(422)
      end

      it 'with empty parameters' do
        put api_v1_product_path(product.id), params: {}, headers: authentication_headers
        expect(response).to have_http_status(200)
      end
    end

    context 'no authentication' do
      let!(:product) { create(:product) }

      it 'with correct params' do
        put api_v1_product_path(product.id), params: { "name": build(:product).name }
        expect(response).to have_http_status(401)
      end

      it 'with invalid params' do
        put api_v1_product_path(product.id), params: { "name": '' }
        expect(response).to have_http_status(401)
      end

      it 'with empty parameters' do
        put api_v1_product_path(product.id), params: {}
        expect(response).to have_http_status(401)
      end
    end
  end

  # delete
  describe 'excluded product' do
    context 'with authentication' do
      let!(:product) { create(:product) }

      it 'existing product' do
        delete api_v1_product_path(product.id), headers: authentication_headers
        expect(response).to have_http_status(204)
      end

      it 'non-existent product' do
        delete api_v1_product_path(-1), headers: authentication_headers
        expect(response).to have_http_status(404)
      end
    end

    context 'no authentication' do
      let!(:product) { create(:product) }

      it 'existing product' do
        delete api_v1_product_path(product.id)
        expect(response).to have_http_status(401)
      end

      it 'non-existent product' do
        delete api_v1_product_path(-1)
        expect(response).to have_http_status(404)
      end
    end
  end
end
