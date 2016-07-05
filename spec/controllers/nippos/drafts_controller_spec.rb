# frozen_string_literal: true
RSpec.describe Nippos::DraftsController do
  describe 'POST create' do
    it 'creates draft and redirects to show' do
      expect do
        post :create, params: {
          draft: '下書き保存',
          nippo: {
            reported_for: Time.zone.today,
            body: FFaker::Lorem.paragraph,
          },
        }
      end.to change(Nippo, :count).by(1)
      expect(response).to redirect_to(nippo_path(assigns(:nippo)))
    end
  end

  describe 'PATCH update' do
    let(:nippo) { FG.create(:nippo, user: current_user) }
    it 'updates draft and redirects to show' do
      expect do
        patch :update, params: { id: nippo.id, draft: '下書き保存', nippo: { body: 'changed' } }
        nippo.reload
      end.to change(nippo, :body)
      expect(response).to redirect_to(nippo_path(nippo))
    end

    context 'nippo has already sent' do
      before { nippo.update(status: :sent) }

      it 'redirects show' do
        patch :update, params: { id: nippo.id, draft: '下書き保存', nippo: { body: 'changed' } }
        expect(response).to redirect_to(nippo_path(nippo))
      end
    end

    context 'when nippo is owned by other' do
      let(:nippo) { FG.create(:nippo) }

      it 'returns 404' do
        expect { patch :update, params: { id: nippo.id, draft: '下書き保存', nippo: { body: 'changed' } } }
          .to raise_error(ActionController::RoutingError)
      end
    end
  end
end
