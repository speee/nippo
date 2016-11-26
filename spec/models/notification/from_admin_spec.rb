# frozen_string_literal: true
RSpec.describe Notification::FromAdmin do
  subject { FG.build(:notification_from_admin) }

  it { is_expected.to be_valid }

  describe '.create_with_parent' do
    it 'creates self instance with parent notification' do
      result = Notification::FromAdmin.create_with_parent(
        title: 'title',
        **FG.attributes_for(:notification_from_admin),
      )

      expect(result.notification).not_to be_nil
      expect(result.notification.title).to eq 'title'
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
