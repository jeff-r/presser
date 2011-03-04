require 'presser_doc'

describe "Presser defaults" do
  it "should have a default doc" do
    # doc = Presser::PresserDoc.new "title", "link", "desc"
    doc = Presser::PresserDoc.new "title" 
    doc.new_doc
    #doc.should eql(" ")
  end
end


