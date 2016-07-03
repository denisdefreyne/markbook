describe MarkBook::HTML do
  let(:content) { raise 'override me' }

  subject do
    tree = DMark::Parser.new(content).parse
    described_class.translate(tree)
  end

  describe 'p' do
    let(:content) { '#p Hello!' }
    it { is_expected.to eql('<p>Hello!</p>') }
  end

  describe 'dt' do
    let(:content) { '#dt Hello!' }
    it { is_expected.to eql('<dt>Hello!</dt>') }
  end

  describe 'dd' do
    let(:content) { '#dd Hello!' }
    it { is_expected.to eql('<dd>Hello!</dd>') }
  end

  describe 'ol' do
    let(:content) { '#ol Hello!' }
    it { is_expected.to eql('<ol>Hello!</ol>') }
  end

  describe 'ul' do
    let(:content) { '#ul Hello!' }
    it { is_expected.to eql('<ul>Hello!</ul>') }
  end

  describe 'li' do
    let(:content) { '#li Hello!' }
    it { is_expected.to eql('<li>Hello!</li>') }
  end

  describe 'code' do
    let(:content) { '#code Hello!' }
    it { is_expected.to eql('<code>Hello!</code>') }
  end

  describe 'kbd' do
    let(:content) { '#kbd Hello!' }
    it { is_expected.to eql('<kbd>Hello!</kbd>') }
  end

  describe 'blockquote' do
    let(:content) { '#blockquote Hello!' }
    it { is_expected.to eql('<blockquote>Hello!</blockquote>') }
  end

  describe 'em' do
    let(:content) { '#em Hello!' }
    it { is_expected.to eql('<em>Hello!</em>') }
  end

  describe 'dl' do
    context 'dl[compact]' do
      let(:content) { "#dl[compact]\n  #dt Foo\n  #dd Bar" }
      it { is_expected.to eql('<dl class="compact"><dt>Foo</dt><dd>Bar</dd></dl>') }
    end

    context 'not compact' do
      let(:content) { "#dl\n  #dt Foo\n  #dd Bar" }
      it { is_expected.to eql('<dl><dt>Foo</dt><dd>Bar</dd></dl>') }
    end
  end

  describe 'h and section' do
    context 'no parent sections' do
      let(:content) { '#h Hello!' }
      it { is_expected.to eql('<h1>Hello!</h1>') }
    end

    context 'one parent section' do
      let(:content) { "#section\n  #h Hello!" }
      it { is_expected.to eql('<section id="hello-"><h2><a href="#hello-" class="permalink">#</a>Hello!</h2></section>') }
    end

    context 'two parent sections' do
      let(:content) { "#section\n  #h Parent!\n  #section\n    #h Hello!" }
      it { is_expected.to eql('<section id="parent-"><h2><a href="#parent-" class="permalink">#</a>Parent!</h2><section id="hello-"><h3><a href="#hello-" class="permalink">#</a>Hello!</h3></section></section>') }
    end
  end

  describe 'firstterm' do
    let(:content) { '#firstterm Hello!' }
    it { is_expected.to eql('<span class="firstterm">Hello!</span>') }
  end

  describe 'prompt' do
    let(:content) { '#prompt Hello!' }
    it { is_expected.to eql('<span class="prompt">Hello!</span>') }
  end

  describe 'filename' do
    let(:content) { '#filename Hello!' }
    it { is_expected.to eql('<span class="filename">Hello!</span>') }
  end

  describe 'note' do
    let(:content) { '#note Hello!' }
    it { is_expected.to eql('<div class="note">Hello!</div>') }
  end

  describe 'todo' do
    let(:content) { '#todo Hello!' }
    it { is_expected.to eql('<div class="todo">Hello!</div>') }
  end

  describe 'link' do
    let(:content) { '#link[target=http://example.com/] Hello!' }
    it { is_expected.to eql('<a href="http://example.com/">Hello!</a>') }
  end

  describe 'listing' do
    context 'lang specified' do
      let(:content) { "#listing[lang=ruby]\n  def foo\n    123\n  end\n" }
      it { is_expected.to eql("<pre><code><span class=\"k\">def</span> <span class=\"nf\">foo</span>\n  <span class=\"mi\">123</span>\n<span class=\"k\">end</span></code></pre>") }
    end

    context 'no lang specified' do
      let(:content) { "#listing\n  def foo\n    123\n  end\n" }
      it { is_expected.to eql("<pre><code>def foo\n  123\nend</code></pre>") }
    end
  end

  describe 'other element' do
    let(:content) { '#aksjdflkasdf stuff' }

    it 'raises' do
      expect { subject }.to raise_error(RuntimeError)
    end
  end
end
