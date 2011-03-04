require 'presser_xmlrpc'

describe "When posting" do
  it "should update the source text file"
  it "should read the source text file correctly" do
    txt = %Q{# Beginning of header
title: Put your title here
# End of header

This is the body
of the file.

This is [a link](http://www.google.com).
    }
    lines = txt.split("\n")
    # puts lines.inspect
    # Make sure that posting increases the line count
    # Parse the returned string, and get the post id
  end
end


