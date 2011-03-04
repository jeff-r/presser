require 'presser_yaml'
require 'presser_opts'

module Presser
  describe PresserOpts do

    it "should restore from yaml string" do 
      opts = PresserOpts.from_yaml dummy_yaml
      opts.parsed.password.should eql("foo")
    end
    it "should generate a yaml string" do 
      opts = PresserOpts.from_yaml dummy_yaml
      # puts "opts.to_yaml: #{opts.to_yaml}"
      opts.to_yaml.should eql(dummy_yaml)
    end

    it "should save the config to a file" do

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
config_file_name: temp_config_file.txt
}
    end

  end

end
