require 'bundler'
Bundler::GemHelper.install_tasks

namespace :specs do
  Rspec = "rspec --tty --color"

  desc "Run all specs"
  task :all do |t|
    sh "rspec spec/*.rb"
  end

  desc "Run doc specs"
  task :docs do |t|
    sh "#{Rspec} spec/presser_doc_spec.rb"
  end

  desc "Run config specs"
  task :config do |t|
    sh "#{Rspec} spec/yaml_spec.rb"
    sh "#{Rspec} spec/presser_opts_spec.rb"
  end

end
