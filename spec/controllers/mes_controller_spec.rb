# frozen_string_literal: true
RSpec.describe MesController do
  describe 'GET show' do
    before { FG.create(:nippo, user: current_user) }
    before { FG.create(:nippo) }

    it "returns http success and shows current user's nippos" do
      get :show
      expect(response).to have_http_status(:success)
      expect(assigns(:my_nippos)).to be_present
      assigns(:my_nippos).each do |nippo|
        expect(nippo.user).to eq current_user
      end
    end
  end
end
