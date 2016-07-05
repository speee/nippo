# frozen_string_literal: true
RSpec.describe HomeController do
  describe 'GET index' do
    it 'returns success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
