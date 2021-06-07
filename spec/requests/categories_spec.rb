# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  before do
    @user = create(:user)
    @login_url = '/api/auth/sign_in'
    @login_params = {
      email: @user.email,
      password: @user.password
    }
  end

  describe '.categories' do
    # index
    it 'get all categories' do
      get api_v1_categories_path
      expect(response).to have_http_status(200)
    end

    # show
    context 'all products of a category' do
      let!(:category) { create(:category) }

      it 'with existing category' do
        get "/api/v1/categories/#{category.id}"
        expect(response).to have_http_status(200)
      end

      it 'with non-existent category' do
        get '/api/v1/categories/1000'
        expect(response).to have_http_status(404)
      end
    end

    # create
    describe 'creating category' do
      context 'with authentication' do
        before { post @login_url, params: @login_params }

        it 'with correct parameters' do
          post '/api/v1/categories', params: { "name": build(:category).name }, headers: headers
          expect(response).to have_http_status(201)
        end

        it 'with invalid parameters' do
          post '/api/v1/categories', params: {}, headers: headers
          expect(response).to have_http_status(422)
        end
      end

      context 'no authentication' do
        it 'with correct parameters' do
          post '/api/v1/categories', params: { "name": build(:category).name }
          expect(response).to have_http_status(401)
        end

        it 'with invalid parameters' do
          post '/api/v1/categories', params: {}
          expect(response).to have_http_status(401)
        end
      end
    end

    # update
    describe 'updating category' do
      context 'with authentication' do
        before { post @login_url, params: @login_params }
        let!(:category) { create(:category) }

        it 'with correct params' do
          put "/api/v1/categories/#{category.id}", params: { "name": build(:category).name }, headers: headers
          expect(response).to have_http_status(200)
        end

        # TODO: este status deveria ser 422 nao?
        it 'with invalid params' do
          put "/api/v1/categories/#{category.id}", params: {}, headers: headers
          expect(response).to have_http_status(200)
        end
      end

      context 'no authentication' do
        let!(:category) { create(:category) }

        it 'with correct params' do
          put "/api/v1/categories/#{category.id}", params: { "name": build(:category).name }
          expect(response).to have_http_status(401)
        end

        it 'with invalid params' do
          put "/api/v1/categories/#{category.id}", params: {}
          expect(response).to have_http_status(401)
        end
      end
    end

    # delete
    describe 'excluded categories' do
      context 'with authentication' do
        before { post @login_url, params: @login_params }
        let!(:category) { create(:category) }

        it 'existing category' do
          delete "/api/v1/categories/#{category.id}", headers: headers
          expect(response).to have_http_status(204)
        end

        it 'non-existent category' do
          delete '/api/v1/categories/-1', headers: headers
          expect(response).to have_http_status(404)
        end
      end

      context 'no authentication' do
        let!(:category) { create(:category) }

        it 'existing category' do
          delete "/api/v1/categories/#{category.id}"
          expect(response).to have_http_status(401)
        end

        it 'non-existent category' do
          delete '/api/v1/categories/-1'
          expect(response).to have_http_status(404)
        end
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
