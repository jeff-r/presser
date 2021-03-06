require 'rexml/document'

module Presser

  class PresserDoc
    attr_accessor :categories, :postid, :post_status
    def initialize *args
      @title       = args[0]        || "This is the title"
      @link        = args[1]        || "http://www.google.com"
      @description = args[2]        || "This is the description"
    end

    def to_s
      str = %Q{# Beginning of header
title:  #{@title}
link:   #{@link}
postid: #{postid}
post_status: #{post_status}
# End of header
#{@description}}
    end

    def new_doc
      doc         = REXML::Document.new
      item        = doc.add_element  "struct"
      title       = item.add_element 'title'
      link        = item.add_element "link"
      description = item.add_element "description"

      description.text = @description
      title.text       = @title
      link.text        = @link

      # str = ""
      # doc.write(str, 2)
      # puts str
      str = ""
      doc.write str
      str
    end
  end

end
