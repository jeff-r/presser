require 'presser'
require 'presser_xmlrpc'
require 'dont_git_this'

describe "Presser net access" do
  before(:each) do
    # @pr  = Presser::Presser.new(["-u #{Presser::NoGit.username}", "-p #{Presser::NoGit.password}"])
    @pr  = Presser::Presser.new(["-U foo", "-u mikey"], "presser_config_file.yml")

    # @rpc = Presser::PresserXmlrpc.new @pr.parsed_options
  end

  it "should be an xmlrpc client" do
    # puts "@pr: #{@pr.parsed_options.inspect}"
    #   @rpc.getUsersBlogs.length.should eql(1)
    #   @rpc.getPostStatusList.length.should eql(4)
    #   @rpc.getTags.length.should eql(0)
    #   @rpc.getPageList.length.should eql(1)
    #   @rpc.getRecentPosts.length.should eql(2)
#    @rpc.newPost
  end
end


