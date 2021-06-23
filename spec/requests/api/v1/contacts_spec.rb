# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Contacts', type: :request do
  before do
    @user = create(:user)
    @login_url = '/api/auth/sign_in'
    @login_params = {
      email: @user.email,
      password: @user.password
    }
  end

  describe '.contacts' do
    describe 'Create' do
      context 'with authentication' do
        before { post @login_url, params: @login_params }
        let!(:p) { create(:contact) }
        let!(:params) do
          { firstname: p.firstname, lastname: p.lastname, email: p.email, message: p.message,
            product_id: p.product_id }
        end

        it 'with correct parameters' do
          post '/api/v1/contacts', params: params, headers: headers
          expect(response).to have_http_status(201)
        end

        it 'with invalid parameters' do
          post '/api/v1/contacts', params: { firstname: '' }, headers: headers
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
