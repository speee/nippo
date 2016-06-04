# frozen_string_literal: true
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

  describe 'POST create' do
    it 'creates new nippo', :vcr do
      expect do
        post :create, nippo: {
          reported_for: Time.zone.today,
          body: FFaker::Lorem.paragraph,
        }
      end.to change(Nippo, :count).by(1)
    end
  end

  describe 'GET show' do
    let(:nippo) { FG.create(:nippo) }

    it 'shows nippo' do
      get :show, id: nippo.id
      expect(assigns(:nippo)).to eq nippo
    end

    it 'creates reaction object and sets pv as 1' do
      get :show, id: nippo.id
      expect(Reaction.find_by(user: current_user, nippo: nippo).page_view).to eq 1
    end

    it 'increment existing reaction page view' do
      get :show, id: nippo.id
      expect { get :show, id: nippo.id }
        .to change { Reaction.find_by(user: current_user, nippo: nippo).page_view }.by(1)
    end
  end
end
