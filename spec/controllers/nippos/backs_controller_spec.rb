# frozen_string_literal: true
RSpec.describe Nippos::BacksController do
  describe 'POST create' do
    it 'shows form' do
      post :create, back: '戻る', nippo: {
        reported_for: Time.zone.today,
        body: FFaker::Lorem.paragraph,
      }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe 'PATCH update' do
    let(:nippo) { FG.create(:nippo, user: current_user) }

    it 'shows form' do
      patch :update, id: nippo.id, back: '戻る', nippo: { body: 'changed' }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end

    context 'nippo has already sent' do
      before { nippo.update(status: :sent) }

      it 'redirects show' do
        patch :update, id: nippo.id, back: '戻る', nippo: { body: 'changed' }
        expect(response).to redirect_to(nippo_path(nippo))
      end
    end

    context 'when nippo is owned by other' do
      let(:nippo) { FG.create(:nippo) }

      it 'returns 404' do
        expect { patch :update, id: nippo.id, back: '戻る', nippo: { body: 'changed' } }
          .to raise_error(ActionController::RoutingError)
      end
    end
  end
end
