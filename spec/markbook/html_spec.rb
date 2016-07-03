describe MarkBook::HTML do
  let(:content) { raise 'override me' }

  subject do
    tree = DMark::Parser.new(content).parse
    described_class.translate(tree)
  end

  context 'p' do
    let(:content) { '#p Hello!' }
    it { is_expected.to eql('<p>Hello!</p>') }
  end

  context 'dt' do
    let(:content) { '#dt Hello!' }
    it { is_expected.to eql('<dt>Hello!</dt>') }
  end

  context 'dd' do
    let(:content) { '#dd Hello!' }
    it { is_expected.to eql('<dd>Hello!</dd>') }
  end

  context 'ol' do
    let(:content) { '#ol Hello!' }
    it { is_expected.to eql('<ol>Hello!</ol>') }
  end

  context 'ul' do
    let(:content) { '#ul Hello!' }
    it { is_expected.to eql('<ul>Hello!</ul>') }
  end

  context 'li' do
    let(:content) { '#li Hello!' }
    it { is_expected.to eql('<li>Hello!</li>') }
  end

  context 'code' do
    let(:content) { '#code Hello!' }
    it { is_expected.to eql('<code>Hello!</code>') }
  end

  context 'kbd' do
    let(:content) { '#kbd Hello!' }
    it { is_expected.to eql('<kbd>Hello!</kbd>') }
  end

  context 'blockquote' do
    let(:content) { '#blockquote Hello!' }
    it { is_expected.to eql('<blockquote>Hello!</blockquote>') }
  end

  # … forthcoming …
end
