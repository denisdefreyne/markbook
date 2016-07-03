require_relative 'lib/markbook/version'

Gem::Specification.new do |s|
  s.name        = 'markbook'
  s.version     = MarkBook::VERSION
  s.homepage    = 'http://rubygems.org/gems/markbook'
  s.summary     = 'markup language for technical writing'
  s.description = 'MarkBook is a markup language for technical writing.'

  s.author  = 'Denis Defreyne'
  s.email   = 'denis.defreyne@stoneship.org'
  s.license = 'MIT'

  s.files =
    Dir['[A-Z]*'] +
    Dir['{lib,spec,samples}/**/*'] +
    ['markbook.gemspec']
  s.require_paths = ['lib']

  s.rdoc_options     = ['--main', 'README.adoc']
  s.extra_rdoc_files = ['LICENSE', 'README.adoc', 'NEWS.md']

  s.required_ruby_version = '>= 2.2.0'

  s.add_runtime_dependency('d-mark', '= 1.0.0a3')
  s.add_development_dependency('bundler', '>= 1.11.2', '< 2.0')
end
