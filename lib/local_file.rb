
module Presser
  class LocalFile
    attr_accessor :title, :body, :params
    def initialize filename
      @in_header = true
      @body = ""
      @filename = filename
      @params = {}
      parse_all_lines
      # puts "The title: #{@title}"
    end

    def parse_all_lines
      File.readlines(@filename).each do |line|
        line = line.strip
        if @in_header
          parse_line line
        else
          # puts "Body: '#{line}'"
          body << line << "\n"
        end
      end
      # puts "params: #{@params}"
      @title = params["title"] || "Default title"
    end

    def parse_line line
      if line == "# End of header"
        @in_header = false
      else
        if line =~ /(.*):(.*)/
          # puts "match: #{line}"
          key = $1.strip
          val = $2.strip
          @params[key] = val
        else
          # puts "No match: #{line}"
        end
      end
    end

  end
end
