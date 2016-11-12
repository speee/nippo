# frozen_string_literal: true
RSpec.describe Notification::FromAdmin do
  subject { FG.build(:notification_from_admin) }

  it { is_expected.to be_valid }

  context 'when after create' do
    before { subject.save }

    it 'creates notification automatically' do
      expect(subject.notification).to be_present
      expect(subject.notification.type).to eq 'from_admin'
    end
  end

  describe 'scope :for_display' do
    let!(:past_notification)    { FG.create(:notification_from_admin, display_limit: Time.zone.today - 1) }
    let!(:current_notification) { FG.create(:notification_from_admin, display_limit: Time.zone.today) }

    subject { Notification::FromAdmin.for_display }

    it { is_expected.not_to include(past_notification) }
    it { is_expected.to     include(current_notification) }
  end
end
