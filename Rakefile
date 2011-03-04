require 'bundler'
Bundler::GemHelper.install_tasks

desc "Run doc specs"
task :docspecs do |t|
  sh "rspec test/presser_doc_spec.rb"
end
desc "Run all specs"
task :allspecs do |t|
  sh "rspec test/*.rb"
end
