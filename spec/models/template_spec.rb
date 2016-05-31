# frozen_string_literal: true
RSpec.describe Template do
  subject { FG.build(:template) }

  it { is_expected.to be_valid }

  describe '.create_default' do
    let(:user) { FG.create(:user) }
    subject { user.template }

    it 'creates default template' do
      expect(subject.subject_yaml).to include('【日報】')
      expect(subject.body).to include('雑感')
      expect(subject.from_name).to eq user.name
    end
  end
end
