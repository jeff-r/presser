require 'presser_xmlrpc'
require 'presser'

module Presser

# This assumes that you've created a config file with 
# valid blog connection data, and that 
# the string sample_post_filename specifies it.
describe "Posting a new post" do
  before(:each) do
  end

  after(:each) do 
    # `rm -f #{sample_post_filename}`
  end

  it "should update the source text file" do
    File.open(sample_post_filename, "w") { |file| file.puts sample_post_text }

    @presser = Presser.new ["-o #{sample_post_filename}"], config_file_name
    @presser.run
  end

  
  it "should read the source text file correctly" do
    lines = sample_post_text.split("\n")
    # puts lines.inspect
    # Make sure that posting increases the line count
    # Parse the returned string, and get the post id
  end

  def sample_post_filename 
    "sample_post.md"
  end

  def sample_post_text
    %Q{# Beginning of header
title: Put your title here
# End of header

This is the body
of the file.

This is [a link](http://www.google.com).
    }
  end

  def config_file_name
    "presser_config_file.yml"
  end

end

end
