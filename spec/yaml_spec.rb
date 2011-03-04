require 'presser_yaml'
require 'presser_opts'

module Presser
  describe PresserOpts do

    it "should restore from yaml string" do 
      opts = PresserOpts.from_yaml dummy_yaml
      puts opts.parsed.inspect
      opts.parsed.password.should eql("foo")
    end

    def dummy_yaml
      %Q{modifiable: true
table: 
  :verbose: false
  :username: WaltKelly
  :password: foo
  :url: http://wordpress/wp/xmlrpc.php
  :file_to_upload: ""
  :upload_file: false
  :pretend: false
  :post_file: false
  :file_to_post: ""
  :make_config_file: false
  :config_file_name: ~/.presser}
    end

  end

end
