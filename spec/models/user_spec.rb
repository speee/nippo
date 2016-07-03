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

  describe '#last_nippo' do
    context 'when user has NOT written nippo' do
      it 'returns nil' do
        expect(subject.last_nippo).to be_nil
      end
    end

    context 'when user has written nippos' do
      let(:expected) { FG.create(:nippo, user: subject) }
      before { FG.create(:nippo, user: subject, reported_for: expected.reported_for - 1) }

      it 'returns last nippo' do
        expect(subject.last_nippo).to eq expected
      end
    end
  end

  describe '.validate_auth!' do
    shared_examples_for 'passing validation' do |email|
      auth = Hashie::Mash.new
      auth.info!.email = email

      it 'does NOT raise errors' do
        expect { User.send(:validate_auth!, auth) }.not_to raise_error
      end
    end

    shared_examples_for 'failing validation' do |email|
      auth = Hashie::Mash.new
      auth.info!.email = email

      it 'raises errors' do
        expect { User.send(:validate_auth!, auth) }.to raise_error
      end
    end

    context 'when Settings.auth.use_whitelist is true' do
      before { Settings.auth.use_whitelist = true }
      after  { Settings.auth.use_whitelist = false }

      context 'when whitelist does NOT contain the email' do
        it_behaves_like 'failing validation', 'hoge.fuga@speee.jp'
      end

      context 'when whitelist contains the email' do
        before { Whitelist::User.create(email: 'hoge.fuga@speee.jp') }
        it_behaves_like 'passing validation', 'hoge.fuga@speee.jp'
      end
    end

    context 'when Settings.auth.use_whitelist is false' do
      context 'domain is speee' do
        it_behaves_like 'passing validation', 'hoge.fuga@speee.jp'
      end

      context 'domain other than speee' do
        it_behaves_like 'failing validation', 'hoge.fuga@gmail.com'
      end
    end
  end
end
