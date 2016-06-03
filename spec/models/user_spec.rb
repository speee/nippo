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

  describe '#needing_tutorial?' do
    subject { FG.create(:user) }

    context 'just after created' do
      it { is_expected.to be_needing_tutorial }
    end

    context 'after updating template' do
      before { subject.template.update(updated_at: subject.template.created_at + 100) }

      it { is_expected.not_to be_needing_tutorial }
    end
  end
end
