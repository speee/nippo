# frozen_string_literal: true
RSpec.describe NotificationsController do
  describe 'GET show from_admin' do
    let(:notification) { FG.create(:notification_from_admin) }

    it 'returns OK' do
      get :show, params: { id: notification.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
