require 'presser'
require 'presser_xmlrpc'
require_relative 'dont_git_this'

describe "Presser net access" do
  before(:each) do
    @pr  = Presser::Presser.new(["-u #{Presser::NoGit.username}", "-p #{Presser::NoGit.password}"])
    @rpc = Presser::PresserXmlrpc.new @pr.options
  end

  it "should be an xmlrpc client" do
    #   @rpc.getUsersBlogs.length.should eql(1)
    #   @rpc.getPostStatusList.length.should eql(4)
    #   @rpc.getTags.length.should eql(0)
    #   @rpc.getPageList.length.should eql(1)
    #   @rpc.getRecentPosts.length.should eql(2)
    @rpc.newPost
  end
end


