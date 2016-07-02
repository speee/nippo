# frozen_string_literal: true
RSpec.describe Nippos::DraftsController do
  describe 'POST create' do
    it 'creates draft and redirects to show' do
      expect do
        post :create, draft: '下書き保存', nippo: {
          reported_for: Time.zone.today,
          body: FFaker::Lorem.paragraph,
        }
      end.to change(Nippo, :count).by(1)
      expect(response).to redirect_to(nippo_path(assigns(:nippo)))
    end
  end

  describe 'PATCH update' do
    let(:nippo) { FG.create(:nippo) }
    it 'updates draft and redirects to show' do
      expect do
        patch :update, id: nippo.id, draft: '下書き保存', nippo: { body: 'changed' }
        nippo.reload
      end.to change(nippo, :body)
      expect(response).to redirect_to(nippo_path(nippo))
    end

    context 'nippo has already sent' do
      before { nippo.update(status: :sent) }

      it 'redirects show' do
        patch :update, id: nippo.id, draft: '下書き保存', nippo: { body: 'changed' }
        expect(response).to redirect_to(nippo_path(nippo))
      end
    end
  end
end
