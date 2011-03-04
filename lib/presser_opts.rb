require 'optparse'
require 'ostruct'

module Presser
class PresserOpts
  ConfigFile = "~/.presser"

  def initialize(args, path=PresserOpts::ConfigFile)
    @config_file_path = path
    @parsed = parse(args)
  end

  def self.from_yaml yaml_string
    new_opts = PresserOpts.new []
    new_opts.parsed = OpenStruct.new YAML::load(yaml_string)["table"]
    new_opts
  end

  def parsed= val
    @parsed = val
  end

  def parsed
    @parsed
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
    str << "username: #{@parsed.username}\n"
    str << "password: #{@parsed.password}\n"
    str << "url: #{@parsed.url}"
  end

  def parse(args)
    parsed = OpenStruct.new
    parsed.verbose          = false
    parsed.username         = "WaltKelly"
    parsed.password         = "pogo"
    parsed.url              = "http://wordpress/wp/xmlrpc.php"
    parsed.file_to_upload   = ""
    parsed.upload_file      = false
    parsed.pretend          = false
    parsed.post_file        = false
    parsed.file_to_post     = ""
    parsed.make_config_file = false
    parsed.config_file_name = "~/.presser"

    @optionParser = OptionParser.new do |opts|
      opts.banner = "Usage: presser [options]"
      # opts.separator = ""

      opts.on('-h', "--help", "Print out this message") do |url|
        puts opts
      end

      opts.on("-c", "--configfile [STRING]", "create a config file") do |filename|
        parsed.make_config_file = true
        parsed.config_file_name = filename.strip
      end

      opts.on("-o", "--post STRING", "Post the named file") do |filename|
        parsed.post_file    = true
        parsed.file_to_post = filename.strip
      end

      opts.on('-p', '--password STRING', 'WordPress admin password') do |password|
        parsed.password = password.strip
      end
      opts.on('-u', '--username STRING', 'WordPress admin username') do |username|
        parsed.username = username.strip
      end
      opts.on('--upload STRING', '-U', 'Upload a file') do |filename|
        parsed.upload_file    = true
        parsed.file_to_upload = filename.strip
      end
      opts.on('--url STRING', '-U STRING', 'WordPress xmlrpc url') do |url|
        parsed.url = url.strip
      end

      # opts.on("-v", "--verbose", "Print out verbose messages") do |verb|
      #   parsed.verbose = true
      # end

    end

    @optionParser.parse!(args)
    parsed
  end


end
end
