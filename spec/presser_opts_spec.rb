require 'presser'
require 'presser_opts'
require_relative 'dont_git_this'

describe "Presser defaults" do
  before(:each) do
    @pr = Presser::Presser.new([""])
    @config_filename = "temp_config.txt"
    `rm -f #{@config_filename}`
  end

  it "should have default username of WaltKelly" do
    @pr.parsed_options.username.should eql('WaltKelly')
  end

  it "should have default password of pogo" do
    @pr.parsed_options.password.should eql('pogo')
  end

  it "should have default url of my test machine" do
    @pr.parsed_options.url = "http://wordpress/wp/xmlrpc.php"
  end

  it "should generate the correct options string for the config file" do
    argv = ["-u    #{Presser::NoGit.username}", 
            "-p    #{Presser::NoGit.password}", 
            "-U #{Presser::NoGit.url}"]

    str = %Q{username: #{Presser::NoGit.username}
password: #{Presser::NoGit.password}
url: #{Presser::NoGit.url}}

    opts = Presser::PresserOpts.new argv
    opts.config_file_contents.should eql(str)
  end

end

