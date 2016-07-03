describe MarkBook do
  describe '.to_html' do
    subject { described_class.to_html(content) }
    let(:content) { '#p Hi!' }
    it { is_expected.to eql('<p>Hi!</p>') }
  end
end
