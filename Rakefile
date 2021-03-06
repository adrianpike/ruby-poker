#!/usr/bin/env ruby

require 'rake/rdoctask'
require "rake/testtask"
require 'rake/gempackagetask'

begin
  require "rubygems"
rescue LoadError
  nil
end

RUBYPOKER_VERSION = "0.0.1"

spec = Gem::Specification.new do |s|
  s.name     = "adrianpike-ruby-poker"
  s.version  = RUBYPOKER_VERSION
  s.date     = "2009-04-23"
  s.rubyforge_project = "rubypoker"
  s.platform = Gem::Platform::RUBY
  s.summary = "Poker library in Ruby"
  s.description = "Ruby library for running poker games."
  s.author  = "Adrian Pike [hat tip: Rob Olson]"
  s.email    = "adrian.pike@gmail.com"
  s.homepage = "http://github.com/adrianpike/ruby-poker"
  s.has_rdoc = true
  s.files    = ["CHANGELOG", 
		"examples/game_example.rb", 
		"examples/quick_example.rb", 
		"lib/card.rb", 
		"lib/deck.rb",
		"lib/game.rb",
		"lib/ruby-poker.rb", 
		"LICENSE", 
		"Rakefile", 
		"README.rdoc", 
		"ruby-poker.gemspec"]
  s.test_files = ["test/test_card.rb", 
    "test/test_poker_hand.rb"]
  s.require_paths << 'lib'
  
  s.extra_rdoc_files = ["README.rdoc", "CHANGELOG", "LICENSE"]
  s.rdoc_options << '--title' << 'Ruby Poker Documentation' <<
                    '--main'  << 'README.rdoc' <<
                    '--inline-source' << '-q'
  
  # s.add_dependency("thoughtbot-shoulda", ["> 2.0.0"])
end

Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
  pkg.need_zip = true
end

Rake::TestTask.new do |test|
  test.libs << "test"
  test.test_files = Dir[ "test/test_*.rb" ]
  test.verbose = true
  test.warning = true
end

desc "Start autotest"
task :autotest do
  ruby "-I lib -w /usr/bin/autotest"
end

Rake::RDocTask.new(:docs) do |rdoc|
  rdoc.rdoc_files.include('README.rdoc', 'CHANGELOG', 'LICENSE', 'lib/')
  rdoc.main     = 'README.rdoc'
  rdoc.rdoc_dir = 'doc/html'
  rdoc.title    = 'Ruby Poker Documentation'
  rdoc.options << '--inline-source'
end