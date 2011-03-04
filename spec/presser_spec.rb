require 'presser'

describe "Presser defaults" do
  before(:each) do
  end

  it "should override saved options with command line" do
    pr = Presser::Presser.new(["-U foo", "-p mikey"], "presser_config_file.yml")
    pr.parsed_options.url.should eql("foo")
    pr.parsed_options.username.should eql("jeff")
    pr.parsed_options.password.should eql("mikey")
  end
end

