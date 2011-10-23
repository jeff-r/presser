
module Presser
  class BlogPost
    attr_accessor :title, :body, :link, :categories, :postid, :post_status

    def initialize
      @categories      = []
      @post_status     = ""
      @postid          = "-1"
      @link            = "http://www.google.com"
      @reading_header  = true
      @post_file_items = {}
    end

    def self.from_filename filename
      bp = BlogPost.new
      bp.load_from_file filename
      bp
    end

    def self.make_file_from_struct presserDoc
      File.open(BlogPost.new_post_filename, "w") do |f|
        f.puts presserDoc.to_s
      end
      BlogPost.new_post_filename
    end

    def load_from_file filename
      parse_all_lines filename
      @title = @post_file_items["title"]     || ""
      @body  = @post_file_items["body"]      || ""
      @link  = @post_file_items["link"]      || ""
      @postid = @post_file_items["postid"]   || ""
    end

    # get the values from a metaWeblog struct
    def parse_struct struct
      @title       = struct["title"]        || ""
      @body        = struct["body"]         || ""
      @link        = struct["link"]         || ""
      @postid      = struct["postid"]       || ""
      @post_status = struct["post_status"]  || ""
      @categories  = struct["categories"]   || ""
    end

    def parse_string str
      lines = str.split("\n")
      parse_all_lines lines
    end

    # Read through a file
    # put all the items describing its post into @post_file_items
    def parse_all_lines filename
      lines = []
      File.readlines(filename).each do |line|
        lines << line
      end
      parse_array_of_lines lines
    end

    def parse_array_of_lines lines
      body = ""
      lines.each do |line|
        line = line.strip
        if @reading_header
          parse_header_line line
        else
          body << line << "\n"
        end
      end
      # puts "post_file_items: #{@post_file_items}"
      @title = @post_file_items["title"] || "Default title"
      @post_file_items["body"] = body
    end

    def parse_header_line line
      if line == "# End of header"
        @reading_header = false
      else
        if line =~ /(.*):(.*)/
          # puts "match: #{line}"
          key = $1.strip
          val = $2.strip
          @post_file_items[key] = val
        else
          # puts "No match: #{line}"
        end
      end
    end

    def to_s
      str = %Q{# Beginning of header
title:  #{@title}
link:   #{@link}
categories: #{@categories}
postid: #{@postid}
post_status: #{@post_status}
# End of header
#{@body}}
    end

    def save_new_post
      str = %Q{# Beginning of header
title: #{@title}
categories: #{@categories}
# End of header

}
      # File.open(BlogPost.new_post_filename, "w") { |file| file.puts str }
      f = File.open(BlogPost.new_post_filename, "w")
      f.puts str
      f.flush
      f.close
      BlogPost.new_post_filename
    end

    def self.new_post_filename
      prefix = "presser_post_"
      @numfiles ||= Dir.glob(prefix + "*").length
      @new_file_name ||= prefix + (@numfiles + 1).to_s + ".md"
    end

    def save_to_file filename
      File.open(filename, "w") { |file| file.puts to_s }
    end

    def dumpself
      puts "Dumping self"
      puts "title: #{@title}"
      puts "body: #{@body}"
      puts "link: #{@link}"
    end
  end
end
