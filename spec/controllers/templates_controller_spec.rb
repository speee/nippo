# frozen_string_literal: true
RSpec.describe TemplatesController do
  describe 'GET show' do
    it "returns http success and shows current user's template" do
      get :show
      expect(response).to have_http_status(:success)
      expect(assigns(:template)).to eq current_user.template
    end
  end
end
