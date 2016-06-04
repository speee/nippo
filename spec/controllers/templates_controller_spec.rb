# frozen_string_literal: true
RSpec.describe TemplatesController do
  describe 'GET show' do
    it "returns http success and shows current user's template" do
      get :show
      expect(response).to have_http_status(:success)
      expect(assigns(:template)).to eq current_user.template
    end
  end

  describe 'PATCH update' do
    let(:subject_after) { FFaker::Lorem.phrase }
    let(:body_after) { FFaker::Lorem.paragraph }
    let(:from_name_after) { FFaker::NameJA.name }

    it 'updates template and redirects to :show' do
      patch :update, template: {
        id: current_user.template.id,
        subject: subject_after,
        body: body_after,
        from_name: from_name_after,
      }

      expect(response).to redirect_to(template_path)
      expect(flash[:first_update]).to eq true
      current_user.template.reload
      expect(current_user.template.subject).to eq subject_after
      expect(current_user.template.body).to eq body_after
      expect(current_user.template.from_name).to eq from_name_after
    end
  end
end
