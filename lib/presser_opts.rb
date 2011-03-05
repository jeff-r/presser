require 'optparse'
require 'ostruct'
require 'yaml'

# Usage: presser [options]
#    -h, --help                       Print out this message
#    -c, --configfile [STRING]        create a config file
#    -d, --deletepost INTEGER         delete a post
#    -g, --getpost INTEGER            delete a post
#    -o, --post STRING                Post the named file
#    -p, --password STRING            WordPress admin password
#    -u, --username STRING            WordPress admin username
#    -U, --upload STRING              Upload a file
#    -r, --url STRING                 WordPress xmlrpc url


module Presser
class PresserOpts
  ConfigFile = "~/.presser"

  def initialize(args, path=PresserOpts::ConfigFile)
    @parsed = OpenStruct.new
    parse(args)
    @parsed.config_file_name = path
  end

  def self.from_yaml yaml_string
    new_opts = PresserOpts.new []
    new_opts.parsed = OpenStruct.new YAML::load(yaml_string)
    new_opts
  end

  def to_yaml
    str =  "verbose: #{parsed.verbose}\n"
    str << "username: #{parsed.username}\n"
    str << "password: #{parsed.password}\n"
    str << "url: #{parsed.url}\n"
    str << "file_to_upload: #{parsed.file_to_upload}\n"
    str << "upload_file: #{parsed.upload_file}\n"
    str << "pretend: #{parsed.pretend}\n"
    str << "post_file: #{parsed.post_file}\n"
    str << "file_to_post: #{parsed.file_to_post}\n"
    str << "make_config_file: #{parsed.make_config_file}\n"
    str << "config_file_name: #{parsed.config_file_name}\n"
    str
  end

  def parsed= val
    @parsed = val
  end

  def parsed
    @parsed
  end

  def save_to_file
    File.open(@parsed.config_file_name, 'w') do |file|
      file.puts to_yaml
    end
  end

  def self.from_file filename
    yaml = File.new(filename).read
    PresserOpts.from_yaml yaml
  end

  def config_file_contents
    str = ""
    str << "username: #{@parsed.username}\n"
    str << "password: #{@parsed.password}\n"
    str << "url: #{@parsed.url}"
  end

  def parse(args)
    @parsed.verbose          ||= false
    @parsed.username         ||= "WaltKelly"
    @parsed.password         ||= "pogo"
    @parsed.url              ||= "http://wordpress/wp/xmlrpc.php"
    @parsed.file_to_upload   ||= ""
    @parsed.upload_file      ||= false
    @parsed.pretend          ||= false
    @parsed.post_file        ||= false
    @parsed.file_to_post     ||= ""
    @parsed.make_config_file ||= false
    @parsed.config_file_name ||= "~/.presser"
    @parsed.delete_post      ||= false
    @parsed.get_post         ||= false
    @parsed.postid   ||= ""

    @optionParser = OptionParser.new do |opts|
      opts.banner = "Usage: presser [options]"
      # opts.separator = ""

      opts.on('-h', "--help", "Print out this message") do |url|
        puts opts
      end

      opts.on("-c", "--configfile [STRING]", "create a config file") do |filename|
        @parsed.make_config_file = true
        @parsed.config_file_name = filename.strip
      end

       opts.on("-d", "--deletepost INTEGER", "delete a post") do |postid|
        @parsed.delete_post    = true
        @parsed.postid = postid
      end

       opts.on("-g", "--getpost INTEGER", "delete a post") do |postid|
        @parsed.get_post    = true
        @parsed.postid = postid
      end

      opts.on("-o", "--post STRING", "Post the named file") do |filename|
        @parsed.post_file    = true
        @parsed.file_to_post = filename.strip
      end

      opts.on('-p', '--password STRING', 'WordPress admin password') do |password|
        @parsed.password = password.strip
      end
      opts.on('-u', '--username STRING', 'WordPress admin username') do |username|
        @parsed.username = username.strip
      end
      opts.on('-U', '--upload STRING', 'Upload a file') do |filename|
        @parsed.upload_file    = true
        @parsed.file_to_upload = filename.strip
      end
      opts.on('-r STRING', '--url STRING', 'WordPress xmlrpc url') do |url|
        @parsed.url = url.strip
      end

      # opts.on("-v", "--verbose", "Print out verbose messages") do |verb|
      #   parsed.verbose = true
      # end

    end

    @optionParser.parse!(args)
    @parsed
  end


end
end
