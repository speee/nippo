# frozen_string_literal: true
RSpec.describe Template do
  subject { FG.build(:template) }

  it { is_expected.to be_valid }

  describe '.create_default' do
    let(:user) { FG.create(:user) }
    subject { user.template }

    it 'creates default template' do
      expect(subject.subject).to include('【日報】')
      expect(subject.body).to include('雑感')
      expect(subject.from_name).to eq user.name
      expect(subject.cc).to be_nil
    end
  end

  describe '#user_updated?' do
    let(:user) { FG.create(:user) }
    subject { user.template }

    context 'before update' do
      it { is_expected.not_to be_user_updated }
    end

    context 'after update' do
      before { subject.update(updated_at: subject.created_at + 100) }
      it { is_expected.to be_user_updated }
    end
  end

  describe '#cc=' do
    where(:input, :formatted) do
      [
        ['test@example.com', 'test@example.com'],
        ['test@example.com,hoge@examle.net', 'test@example.com,hoge@examle.net'],
        [' test@example.com , hoge@examle.net ', 'test@example.com,hoge@examle.net'],
        ['test@example.com,invalid', 'test@example.com'],
        ['invalidonly', nil],
        ['', nil],
      ]
    end

    with_them do
      it "format '#{params[:input]}' to #{params[:formatted]}" do
        subject.cc = input
        expect(subject.cc).to eq formatted
      end
    end
  end
end
