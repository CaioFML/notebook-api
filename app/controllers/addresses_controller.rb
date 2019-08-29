class AddressesController < ApplicationController
  before_action :set_address

  def show
    render json: @address
  end

  private

  def set_address
    @address = Contact.find(params[:contact_id]).address
  end
end