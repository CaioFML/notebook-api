require 'rails_helper'

RSpec.describe V1::ContactsController, type: :controller do
  it 'request index and return status 200, OK' do
    request.accept = 'application/vnd.api+json'
    get :index
    expect(response).to have_http_status :ok
  end

  it 'request index and return status 406, not acceptable' do
    get :index
    expect(response).to have_http_status :not_acceptable
  end
end