# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  describe '.categories' do
    # index
    it 'get all categories' do
      get api_v1_categories_path
      expect(response).to have_http_status(:ok)
    end

    # show
    context 'all products of a category' do
      let!(:category) { create(:category) }

      it 'with existing category' do
        get api_v1_category_path(category.id)
        expect(response).to have_http_status(:ok)
      end

      it 'with non-existent category' do
        get api_v1_category_path(-1)
        expect(response).to have_http_status(:not_found)
      end
    end

    # create
    describe 'creating category' do
      context 'with authentication' do
        it 'with correct parameters' do
          post api_v1_categories_path, params: { "name": build(:category).name }, headers: authentication_headers
          expect(response).to have_http_status(201)
        end

        it 'with invalid parameters' do
          post api_v1_categories_path, params: {}, headers: authentication_headers
          expect(response).to have_http_status(422)
        end
      end

      context 'no authentication' do
        it 'with correct parameters' do
          post api_v1_categories_path, params: { "name": build(:category).name }
          expect(response).to have_http_status(401)
        end

        it 'with invalid parameters' do
          post api_v1_categories_path, params: {}
          expect(response).to have_http_status(401)
        end
      end
    end

    # update
    describe 'updating category' do
      context 'with authentication' do
        let!(:category) { create(:category) }

        it 'with correct params' do
          put api_v1_category_path(category.id), params: { "name": build(:category).name },
                                                 headers: authentication_headers
          expect(response).to have_http_status(:ok)
        end

        # TODO: este status deveria ser 422 nao?
        it 'with invalid params' do
          put api_v1_category_path(category.id), params: {}, headers: authentication_headers
          expect(response).to have_http_status(:ok)
        end
      end

      context 'no authentication' do
        let!(:category) { create(:category) }

        it 'with correct params' do
          put api_v1_category_path(category.id), params: { "name": build(:category).name }
          expect(response).to have_http_status(:unauthorized)
        end

        it 'with invalid params' do
          put api_v1_category_path(category.id), params: {}
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    # delete
    describe 'excluded categories' do
      context 'with authentication' do
        let!(:category) { create(:category) }

        it 'existing category' do
          delete api_v1_category_path(category.id), headers: authentication_headers
          expect(response).to have_http_status(:no_content)
        end

        it 'non-existent category' do
          delete api_v1_category_path(-1), headers: authentication_headers
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'no authentication' do
        let!(:category) { create(:category) }

        it 'existing category' do
          delete api_v1_category_path(category.id)
          expect(response).to have_http_status(:unauthorized)
        end

        it 'non-existent category' do
          delete api_v1_category_path(-1)
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
