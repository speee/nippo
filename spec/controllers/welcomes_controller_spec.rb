# frozen_string_literal: true
RSpec.describe WelcomesController do
  describe 'GET show' do
    it 'returns success' do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET sign_out' do
    it 'redirects to login form' do
      get :sign_out
      expect(response).to redirect_to(welcome_path)
    end
  end
end
