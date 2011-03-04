require 'optparse'
require 'ostruct'

class PresserOpts
  def self.parse(args)
    options = OpenStruct.new
    options.verbose        = false
    options.username       = "WaltKelly"
    options.password       = "pogo"
    options.url            = "http://wordpress/wp/xmlrpc.php"
    options.file_to_upload = ""
    options.upload_file    = false
    options.pretend        = false
    options.post_file      = false
    options.file_to_post   = ""

    @opts = OptionParser.new do |opts|
      opts.banner = "Usage: presser [options]"
      # opts.separator = ""

      opts.on('-h', "--help", "Print out this message") do |url|
        puts opts
      end

      opts.on("-o", "--post STRING", "Post the named file") do |filename|
        options.post_file    = true
        options.file_to_post = filename
      end

      opts.on('-p', '--password STRING', 'WordPress admin password') do |password|
        options.password = password
      end
      opts.on('-u', '--username STRING', 'WordPress admin username') do |username|
        options.username = username
      end
      opts.on('--upload STRING', '-U', 'Upload a file') do |filename|
        options.upload_file    = true
        options.file_to_upload = filename
      end
      opts.on('--url STRING', 'WordPress xmlrpc url') do |url|
        options.url = url
      end

      # opts.on("-v", "--verbose", "Print out verbose messages") do |verb|
      #   options.verbose = true
      # end

    end

    @opts.parse!(args)
    options
  end

end

