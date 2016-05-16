# frozen_string_literal: true
RSpec.describe Template do
  subject { FG.build(:template) }

  it { is_expected.to be_valid }
end
