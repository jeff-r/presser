require 'optparse'
require 'ostruct'

class PresserOpts
  ConfigFile = "~/.presser"

  def initialize(args, path=PresserOpts::ConfigFile)
    @config_file_path = path
    @options = PresserOpts.parse(args)
  end

  # if the specified file doesn't exist, create it
  # Specify it here as an optional parameter so we can
  # give it a temp file for testing
  def create_config_file
    puts "'#{@config_file_path}'"
    `touch #{@config_file_path}`
  end

  def config_file_contents
    str = ""
    str << "username: #{@options.username}\n"
    str << "password: #{@options.password}\n"
    str << "url: #{@options.url}"
  end

  def self.parse(args)
    options = OpenStruct.new
    options.verbose        = false
    options.username       = "WaltKelly"
    options.password       = "pogo"
    options.url            = ""
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
        options.file_to_post = filename.strip
      end

      opts.on('-p', '--password STRING', 'WordPress admin password') do |password|
        options.password = password.strip
      end
      opts.on('-u', '--username STRING', 'WordPress admin username') do |username|
        options.username = username.strip
      end
      opts.on('--upload STRING', '-U', 'Upload a file') do |filename|
        options.upload_file    = true
        options.file_to_upload = filename.strip
      end
      opts.on('--url STRING', '-U STRING', 'WordPress xmlrpc url') do |url|
        options.url = url.strip
      end

      # opts.on("-v", "--verbose", "Print out verbose messages") do |verb|
      #   options.verbose = true
      # end

    end

    @opts.parse!(args)
    options
  end


end

