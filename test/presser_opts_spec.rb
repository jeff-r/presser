require 'presser'

describe "Presser defaults" do
  before(:each) do
    @pr = Presser::Presser.new([""])
  end
  it "should have default username of WaltKelly" do
    @pr.options.username.should eql('WaltKelly')
  end
  it "should have default password of pogo" do
    @pr.options.password.should eql('pogo')
  end
  it "should have default url of my test machine" do
    @pr.options.url = "http://wordpress/wp/xmlrpc.php"
  end
end

