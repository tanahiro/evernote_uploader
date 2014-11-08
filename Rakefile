require "bundler/gem_tasks"
require "rake/testtask"
require 'rdoc/task'

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
end

task :default => :test

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir   = 'rdoc'
  rdoc.main       = 'README.md'
  rdoc.rdoc_files.include(%w[README.md lib])
end

