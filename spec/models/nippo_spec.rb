# frozen_string_literal: true
RSpec.describe Nippo do
  subject { FG.build(:nippo) }

  it { is_expected.to be_valid }

  describe '#dated_subject' do
    before do
      subject.subject = 'pre %s post'
      subject.reported_for = Date.parse('2016-06-04')
    end

    it 'returns subject string when date inserted' do
      expect(subject.dated_subject).to eq 'pre 2016/06/04 post'
    end
  end

  describe '.default_report_date' do
    shared_examples '.default_report_date' do |input, output|
      let(:now) { Time.zone.parse(input) }
      let(:expected) { Date.parse(output) }

      it 'returns expected date' do
        expect(Nippo.default_report_date(now)).to eq expected
      end
    end

    context 'Mon-Fri after 10AM' do
      include_examples '.default_report_date', '2016-06-06 10:00', '2016-06-06'
      include_examples '.default_report_date', '2016-06-07 10:00', '2016-06-07'
      include_examples '.default_report_date', '2016-06-08 10:00', '2016-06-08'
      include_examples '.default_report_date', '2016-06-09 10:00', '2016-06-09'
      include_examples '.default_report_date', '2016-06-10 10:00', '2016-06-10'
    end

    context 'Tue-Fri before 10AM' do
      include_examples '.default_report_date', '2016-06-07 09:59', '2016-06-06'
      include_examples '.default_report_date', '2016-06-08 09:59', '2016-06-07'
      include_examples '.default_report_date', '2016-06-09 09:59', '2016-06-08'
      include_examples '.default_report_date', '2016-06-10 09:59', '2016-06-09'
    end

    context 'before Mon 10AM' do
      include_examples '.default_report_date', '2016-06-11 09:59', '2016-06-10'
      include_examples '.default_report_date', '2016-06-11 10:00', '2016-06-10'
      include_examples '.default_report_date', '2016-06-12 09:59', '2016-06-10'
      include_examples '.default_report_date', '2016-06-12 10:00', '2016-06-10'
      include_examples '.default_report_date', '2016-06-13 09:59', '2016-06-10'
    end
  end
end
