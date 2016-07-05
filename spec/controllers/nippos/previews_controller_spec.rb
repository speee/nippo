# frozen_string_literal: true
RSpec.describe Nippos::PreviewsController do
  describe 'POST create' do
    it 'shows preview' do
      post :create, params: {
        preview: 'プレビュー',
        nippo: {
          reported_for: Time.zone.today,
          body: FFaker::Lorem.paragraph,
        },
      }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:preview)
    end

    context 'when nippo is invalid' do
      it 'show alert and form' do
        post :create, params: {
          preview: 'プレビュー',
          nippo: {
            reported_for: Time.zone.today,
            body: '',
          },
        }
        expect(flash[:alert]).to be_present
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH update' do
    let(:nippo) { FG.create(:nippo, user: current_user) }

    it 'shows preview' do
      patch :update, params: { id: nippo.id, preview: 'プレビュー', nippo: { body: 'changed' } }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:preview)
    end

    context 'when nippo is invalid' do
      it 'show alert and form' do
        patch :update, params: { id: nippo.id, preview: 'プレビュー', nippo: { body: '' } }
        expect(flash[:alert]).to be_present
        expect(response).to render_template(:show)
      end
    end

    context 'nippo has already sent' do
      before { nippo.update(status: :sent) }

      it 'redirects show' do
        patch :update, params: { id: nippo.id, preview: 'プレビュー', nippo: { body: 'changed' } }
        expect(response).to redirect_to(nippo_path(nippo))
      end
    end

    context 'when nippo is owned by other' do
      let(:nippo) { FG.create(:nippo) }

      it 'returns 404' do
        expect { patch :update, params: { id: nippo.id, preview: 'プレビュー', nippo: { body: 'changed' } } }
          .to raise_error(ActionController::RoutingError)
      end
    end
  end
end
