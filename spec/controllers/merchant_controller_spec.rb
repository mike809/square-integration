require 'rails_helper'

RSpec.describe MerchantController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #callback" do
    let(:valid_code) { 'valid_code' }
    let(:invalid_code) { 'invalid_code' }

    let(:valid_code_response) {{ access_token: 'tony_stark' }}
    let(:invalid_code_response) {{ error: 'Invalid Code' }}

    before do
      allow(SquareAuthorization).to receive(:authorize!).with(valid_code).and_return(valid_code_response)
      allow(SquareAuthorization).to receive(:authorize!).with(invalid_code).and_return(invalid_code_response)
    end

    subject do
      get :callback, params: params
    end

    context 'when we get a callback with a valid code' do
      let(:params) { { code: valid_code } }
      it 'creates a new merchant' do

        expect{ subject }.to change { Merchant.count }.by(1)
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
