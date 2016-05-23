require 'rails_helper'

RSpec.describe NipposController do
  describe 'GET new' do
    it 'returns OK and shows template' do
      get :new
      expect(response).to have_http_status(:success)
      expect(assigns(:nippo)).to be_present
      expect(assigns(:nippo).body).to eq current_user.template.body
      expect(assigns(:nippo).reported_for).to be_present
    end
  end
end
