# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Contacts', type: :request do
  describe '.contacts' do
    describe 'Create' do
      context 'with valid params' do
        let!(:product) { create(:product) }
        let(:contact_params) { attributes_for(:contact, product_id: product.id) }

        it 'should create the contact' do
          post api_v1_contacts_path, params: contact_params
          expect(response).to have_http_status(201)
        end
      end

      context 'with invalid params' do
        it "shouldn't create the contact" do
          post api_v1_contacts_path
          expect(response).to have_http_status(422)
        end
      end
    end
  end
end
