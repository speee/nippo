# frozen_string_literal: true
RSpec.describe User do
  subject { FG.build(:user) }

  it { is_expected.to be_valid }
end
