require './lib/integration/contact/contact_bot'

class Api::V1::ContactsController < ApplicationController

  before_action :set_contact, only: [:update, :destroy]
  before_action :authenticate_api_user!, only: [:index, :show, :update, :destroy]

  def index
    render json: Contact.all
  end
  #-----------------------------------------------------------------------
  def show
  end
  #-----------------------------------------------------------------------
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact, status: :created
      Integration::Contact::ContactBot.new.message(@contact)
    else
      render json: @contact.errors, status: :unprocessable_entity
    end

  end
  #-----------------------------------------------------------------------
  def update
    if @contact.update(contact_params)
      render json: @contact, status: :ok
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end
  #-----------------------------------------------------------------------
  def destroy
    @contact.destroy
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end
  #-----------------------------------------------------------------------
  def contact_params
    params.permit(:firstname, :lastname, :message, :email, :product_id)
  end
end
