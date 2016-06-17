# frozen_string_literal: true
RSpec.describe NippoSender do
  subject { NippoSender.new(nippo: FG.create(:nippo, status: :draft)) }

  it { is_expected.to be_valid }

  it { is_expected.to be_invalid_on(:user).with(nil) }
  it { is_expected.to be_invalid_on(:user).with(FG.create(:user)) }

  it { is_expected.to be_invalid_on(:nippo).with(nil) }
  it { is_expected.to be_invalid_on(:nippo).with(FG.create(:nippo, status: :sending)) }
  it { is_expected.to be_invalid_on(:nippo).with(FG.create(:nippo, status: :sent)) }

  context 'when validation fails' do
    before { subject.nippo.update(status: :sending) }

    it 'returns nil and stores error' do
      expect(subject.run).to be_nil
      expect(subject.errors).not_to be_empty
    end

    it 'stores error and does NOT change nippo status' do
      expect { subject.run }.not_to change(subject.nippo, :status)
    end
  end

  context 'when calling GMail API fails', :vcr do
    it 'returns nil, stores error, and update nippo status to :draft' do
      expect(subject.run).to be_nil
      expect(subject.errors).not_to be_empty
      expect(subject.nippo.draft?).to eq true
    end
  end

  context 'when calling GMail API succeed', :vcr do
    it 'returns true and update nippo status to :sent' do
      expect(subject.run).to eq true
      expect(subject.errors).to be_empty
      expect(subject.nippo.sent?).to eq true
    end
  end
end
