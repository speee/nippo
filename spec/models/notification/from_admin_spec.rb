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
end
