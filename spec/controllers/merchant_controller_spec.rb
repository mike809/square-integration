require 'rails_helper'

RSpec.describe MerchantController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #callback" do
    let(:access_token) { 'tony_stark' }
    let(:valid_code) { 'valid_code' }
    let(:invalid_code) { 'invalid_code' }

    let(:valid_code_response) {{ access_token: access_token }}
    let(:invalid_code_response) {{ error: 'Invalid Code' }}

    let(:locations_response) { Hashie::Mash.new({ locations: [] }) }
    let(:transactions_response) { Hashie::Mash.new({ transactions: [] }) }

    before do
      allow(SquareAuthorization).to receive(:authorize!).with(valid_code).and_return(valid_code_response)
      allow(SquareAuthorization).to receive(:authorize!).with(invalid_code).and_return(invalid_code_response)
      allow_any_instance_of(SquareConnect::LocationApi).to receive(:list_locations).with(access_token).and_return(locations_response)
      allow_any_instance_of(SquareConnect::TransactionApi).to receive(:list_transactions).and_return(transactions_response)
    end

    subject do
      get :callback, params: params
    end

    context 'when we get a callback with a valid code' do
      let(:params) { { code: valid_code } }
      it 'creates a new merchant' do
        expect{ subject }.to change { Merchant.count }.by(1)
      end

      context 'when the merchant has some location' do
        let(:locations_response) do
          Hashie::Mash.new({
             locations: [
              {
                id: "18YC4JDH91E1H",
                name: "Empire State Building",
                address: {
                  address_line_1: "123 Main St",
                  locality: "San Francisco",
                  administrative_district_level_1: "CA",
                  postal_code: "94114",
                  country: "US"
                },
                timezone: "America/Los_Angeles",
                capabilities: [
                  "CREDIT_CARD_PROCESSING"
                ]
              }
            ]
          })
        end

        it 'creates a new merchant location' do
          expect{ subject }.to change { MerchantLocation.count }.by(1)
        end
      end
    end

    context 'when we get a callback with an error' do
      let(:params) { { code: invalid_code } }
      it 'creates does not create a merchant' do
        expect{ subject }.not_to change { Merchant.count }
      end
    end
  end
end
