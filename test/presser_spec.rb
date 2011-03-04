require 'presser'

describe "Presser defaults" do
  before(:each) do
    @pr = Presser::Presser.from_argv([""])
  end
end

