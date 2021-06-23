# frozen_string_literal: true

require './lib/integration/contact/contact_bot'

class Api::V1::ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact, status: :created
      Integration::Contact::ContactBot.new.message(@contact)
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.permit(:firstname, :lastname, :message, :email, :product_id)
  end
end
