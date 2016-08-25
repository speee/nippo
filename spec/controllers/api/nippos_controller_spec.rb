# frozen_string_literal: true
RSpec.describe Api::NipposController do
  describe 'Unauthorized Error' do
    it 'returns error' do
      get :index
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET index' do
    let(:token) { double :acceptable? => true }
    let(:user) { FG.create(:user) }
    before do
      controller.stub(:doorkeeper_token) { token }
      controller.stub(:current_user) { user }
    end
    it 'returns success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end