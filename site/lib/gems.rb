require 'nanoc-git'
require 'markbook/nanoc'
require 'rouge'

class DMarkRougeLexer < Rouge::RegexLexer
  tag 'd-mark'
  filenames '*.dmark'

  state :root do
    rule /^(  )*#[a-z][a-z0-9]*/, Name::Tag
    rule /%[a-z][a-z0-9]*/, Name::Tag
  end
end
