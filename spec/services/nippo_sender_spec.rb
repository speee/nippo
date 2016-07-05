# frozen_string_literal: true
RSpec.describe NippoSender do
  let(:nippo) { FG.create(:nippo, status: :draft) }
  subject { NippoSender.new(nippo: nippo) }

  it { is_expected.to be_valid }

  it { is_expected.to be_invalid_on(:user).with(nil) }
  it { is_expected.to be_invalid_on(:user).with(FG.create(:user)) }

  it { is_expected.to be_invalid_on(:nippo).with(nil) }
  it { is_expected.to be_invalid_on(:nippo).with(FG.create(:nippo, status: :sending)) }
  it { is_expected.to be_invalid_on(:nippo).with(FG.create(:nippo, status: :sent)) }

  context 'when validation fails' do
    before { nippo.update(status: :sending) }

    it 'returns nil and stores error' do
      expect(subject.run).to be_nil
      expect(subject.errors).not_to be_empty
    end

    it 'stores error and does NOT change nippo status' do
      expect { subject.run }.not_to change(nippo, :status)
    end
  end

  context 'when calling GMail API fails', :vcr do
    it 'returns nil, stores error, and update nippo status to :draft' do
      expect(subject.run).to be_nil
      expect(subject.errors).not_to be_empty
      expect(nippo.draft?).to eq true
    end
  end

  context 'when calling GMail API succeed', :vcr do
    it 'returns true and update nippo status to :sent' do
      expect(subject.run).to eq true
      expect(subject.errors).to be_empty
      expect(nippo.sent?).to eq true
    end
  end

  describe '#from' do
    let(:user) { nippo.user }
    let(:template) { user.template }

    context 'when from_name is empty' do
      before { template.update(from_name: '') }
      it 'returns the value `email`' do
        expect(subject.send(:from)).to eq user.email
      end
    end

    context 'when from_name contains japanese' do
      before { template.update(from_name: '日本語') }
      it 'returns MIME encoded' do
        @actual = subject.send(:from)
        expect(NKF.nkf('-mw', @actual)).to eq "日本語 <#{user.email}>"
      end
    end
  end
end
