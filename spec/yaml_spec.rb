require 'presser_yaml'
require 'presser_opts'

module Presser
  describe PresserOpts do

    before(:each) do 
      @opts = PresserOpts.from_yaml dummy_yaml
    end

    it "should restore from yaml string" do 
      @opts.parsed.password.should eql("foo")
    end
    it "should generate a yaml string" do 
      @opts.to_yaml.should eql(dummy_yaml)
    end

    it "should save the config to a file" do
      `rm -f #{test_config_file}`

      @opts.parsed.config_file_name.should eql(test_config_file)
      File.exists?(@opts.parsed.config_file_name).should be_false
      @opts.save_to_file
      File.exists?(@opts.parsed.config_file_name).should be_true

      File.new(test_config_file).read.should eql dummy_yaml
    end

    it "should load from a config file" do
      `rm -f #{test_config_file}`
      @opts.save_to_file
      opts2 = PresserOpts.from_file test_config_file

      @opts.parsed.config_file_name.should eql(opts2.parsed.config_file_name)
    end


    # ******************************************************
    # Define some strings for testing
    #
    def test_config_file
      "temp_config_file.txt"
    end

    def dummy_yaml
      %Q{verbose: false
username: WaltKelly
password: foo
url: http://wordpress/wp/xmlrpc.php
file_to_upload: 
upload_file: false
pretend: false
post_file: false
file_to_post: 
make_config_file: false
config_file_name: #{test_config_file}
}
    end

  end

end
