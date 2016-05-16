# frozen_string_literal: true
RSpec.describe User do
  subject { FG.build(:user) }

  it { is_expected.to be_valid }

  context 'when user is created' do
    subject { FG.create(:user) }
    it 'create default template together' do
      expect(subject.template).to be_present
    end
  end
end
