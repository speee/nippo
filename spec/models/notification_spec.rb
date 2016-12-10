# frozen_string_literal: true
RSpec.describe Notification, type: :model do
  subject { FG.build(:notification) }

  it { is_expected.to be_valid }
end
