# frozen_string_literal: true
RSpec.describe Nippo do
  subject { FG.build(:nippo) }

  it { is_expected.to be_valid }
end
