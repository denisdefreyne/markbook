require 'd-mark'

require_relative 'markbook/version.rb'
require_relative 'markbook/html'

module MarkBook
  def self.to_html(content)
    tree = DMark::Parser.new(content).parse
    MarkBook::HTML.translate(tree)
  end
end
