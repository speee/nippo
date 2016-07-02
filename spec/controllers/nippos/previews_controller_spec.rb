# frozen_string_literal: true
RSpec.describe Nippos::PreviewsController do
  describe 'POST create' do
    it 'shows preview' do
      post :create, preview: 'プレビュー', nippo: {
        reported_for: Time.zone.today,
        body: FFaker::Lorem.paragraph,
      }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:preview)
    end
  end

  describe 'PATCH update' do
    let(:nippo) { FG.create(:nippo) }

    it 'shows preview' do
      patch :update, id: nippo.id, preview: 'プレビュー', nippo: { body: 'changed' }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:preview)
    end

    context 'nippo has already sent' do
      before { nippo.update(status: :sent) }

      it 'redirects show' do
        patch :update, id: nippo.id, preview: 'プレビュー', nippo: { body: 'changed' }
        expect(response).to redirect_to(nippo_path(nippo))
      end
    end
  end
end
