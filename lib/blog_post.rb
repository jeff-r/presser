
module Presser
  class BlogPost
    attr_accessor :title, :body, :link

    def initialize
    end

    def self.from_filename filename
      self.from_local_file LocalFile.new(filename)
    end

    def self.from_local_file localfile
      bp = BlogPost.new
      bp.title = localfile.title
      bp.body  = localfile.body
      bp
    end

    def dumpself
      puts "Dumping self"
      puts "title: #{@title}"
      puts "body: #{@body}"
      puts "link: #{@link}"
    end
  end
end
