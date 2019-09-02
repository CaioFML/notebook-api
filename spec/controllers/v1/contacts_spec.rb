require 'rails_helper'

class Hash
  def json(parts)
    ary = parts.split(">")
    ary.reduce(self) do |memo, key|
      memo.fetch(key.to_s.strip) if memo
    end
  end
end

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

  it 'GET v1/contacts/:id' do
    contact = Contact.first
    request.accept = 'application/vnd.api+json'
    get :show, params: {id: contact.id}
    response_body = JSON.parse(response.body)

    expect(response_body.fetch('data').fetch('id')).to eq contact.id.to_s
    expect(response_body.json('data > id')).to eq contact.id.to_s
    expect(response_body.fetch('data').fetch('type')).to eq 'contacts'
    expect(response_body.json('data > type')).to eq 'contacts'
  end
end