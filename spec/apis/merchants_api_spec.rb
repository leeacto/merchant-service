require 'spec_helper'

def app
  ApplicationApi
end

describe MerchantsApi do
  include Rack::Test::Methods

  describe 'get /:id' do
    context 'with valid attributes' do
      it 'returns the correct merchant' do
        m = FactoryGirl.create(:merchant)
        get "/merchants/#{m.id}"
        expect(parsed_response[:data].id).to eq m.id.to_s
      end
    end

    context 'with invalid attributes' do
      it 'returns Merchant Not Found error' do
        get "/merchants/0"
        expected_error = Hashie::Mash.new({ code: 'api_error', message: 'Merchant Not Found' })
        expect(parsed_response[:error]).to eq expected_error
        expect(last_response.status).to eq 404
      end
    end
  end

  describe 'post /' do
    context 'with valid attributes' do
      it 'Creates a new Merchant' do
        params = { name: 'Pizza Hut', email_address: 'pizza@hut.com' }
        expect{ post "/merchants", params }.to change{ Merchant.count }.by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a merchant when missing name' do
        params = { email_address: 'pizza@hut.com' }
        expected_error = Hashie::Mash.new({ code: 'api_error', message: 'name is missing' })
        expect{ post "/merchants", params }.not_to change{ Merchant.count }
        expect(last_response.status).to eq 400
        expect(parsed_response[:error]).to eq expected_error
      end

      it 'does not create a merchant when email is taken' do
        m = FactoryGirl.create(:merchant)
        params = { name: "Bob's Burgers", email_address: m.email_address }
        expected_error = Hashie::Mash.new({ code: 'api_error', message: 'Email address has already been taken' })
        expect{ post "/merchants", params }.not_to change{ Merchant.count }
        expect(last_response.status).to eq 400
        expect(parsed_response[:error]).to eq expected_error
      end
    end
  end


end
