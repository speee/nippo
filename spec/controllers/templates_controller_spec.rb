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
    let(:subject_yaml_after) { FFaker::Lorem.phrase }
    let(:body_after) { FFaker::Lorem.paragraph }

    it 'updates template and redirects to :show' do
      patch :update, template: {
        id: current_user.template.id,
        subject_yaml: subject_yaml_after,
        body: body_after,
      }

      expect(response).to redirect_to(template_path)
      current_user.template.reload
      expect(current_user.template.subject_yaml).to eq subject_yaml_after
      expect(current_user.template.body).to eq body_after
    end
  end
end
