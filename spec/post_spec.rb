require 'presser_xmlrpc'
require 'presser'

module Presser

# This assumes that you've created a config file with 
# valid blog connection data, and that 
# the string sample_post_filename specifies it.
describe BlogPost do
  before(:each) do
  end

  after(:each) do 
    delete_sample_file
  end

  it "should read the source text file correctly" do
    make_sample_file
    bp = BlogPost.from_filename sample_post_filename
    bp.title.should eql("Put your title here")
    bp.postid.should eql("")
    
    lines = sample_post_text.split("\n")
    # puts lines.inspect
    # Make sure that posting increases the line count
    # Parse the returned string, and get the post id
  end

  it "should parse a metaWeblog struct" do
    bp = BlogPost.new
    bp.parse_struct sample_metaWeblog_struct
    bp.title.should eql("Put your title here")
    # bp.postid.should eql(119)
  end

  it "should update the source text file" do
    make_sample_file
    bp_initial = BlogPost.from_filename sample_post_filename

    post_sample_file

    bp_result  = BlogPost.from_filename sample_post_filename

    bp_result.title.should eql bp_initial.title
    bp_result.postid.should_not eql ""
  end

  it "should delete a post when told to" do
    make_sample_file
    post_sample_file
    bp_result  = BlogPost.from_filename sample_post_filename

    postid = bp_result.postid
    delete_result = delete_post postid
    delete_result.should be_true   # always returns true. Even for failure.

    null_post = get_post postid
    null_post.should be_nil
  end

  it "should create a new post for a new file" 

  def make_sample_file
    File.open(sample_post_filename, "w") { |file| file.puts sample_post_text }
  end

  def post_sample_file
    presser = Presser.new ["-o #{sample_post_filename}"], config_file_name
    presser.run
  end

  def get_post postid
    presser = Presser.new ["-g #{postid}"], config_file_name
    presser.run
  end

  def delete_post postid
    presser = Presser.new ["-d #{postid}"], config_file_name
    presser.delete_post postid
  end

  def delete_sample_file
    `rm -f #{sample_post_filename}`
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


      # "dateCreated"=>#<XMLRPC::DateTime:0x00000100d96d80 @year=2011, @month=3, @day=5, @hour=2, @min=40, @sec=4>, 
  def sample_metaWeblog_struct
    {
      "dateCreated"=>"01/01/2011",
      "userid"=>"1", 
        "description"=>"This is the body\nof the file.\n\nThis is [a link](http://www.google.com).", 
        "title"=>"Put your title here", 
        "link"=>"http://wordpress/wp/?p=119", 
        "permaLink"=>"http://wordpress/wp/?p=119", 
        "categories"=>["Uncategorized"], 
        "mt_excerpt"=>"", 
        "mt_text_more"=>"", 
        "mt_allow_comments"=>1, 
        "mt_allow_pings"=>1, 
        "mt_keywords"=>"", 
        "wp_slug"=>"put-your-title-here-7", 
        "wp_password"=>"", 
        "wp_author_id"=>"1", 
        "wp_author_display_name"=>"jeff", 
        "post_status"=>"publish", 
        "custom_fields"=>[{"id"=>"180", "key"=>"_encloseme", "value"=>"1"}], 
        "wp_post_format"=>"standard", 
        "sticky"=>false
    }
  end

end

end

# Struct returned by metaWeblog.getPost:
