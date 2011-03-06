require_relative 'presser_opts'
require 'net/http'
require 'xmlrpc/client'
require_relative 'presser_xmlrpc'
require 'fileutils'

module Presser

  class Presser
    CONFIGFILE = "#{ENV['HOME']}/.presser"
    def initialize(args, filename=nil)
      @args = args

      filename ||= CONFIGFILE
      load_config_file filename
    end

    def load_config_file filename
      @options = PresserOpts.new Array.new @args
      if File.exists? filename
        @options.load_file filename
      #  @options.parse Array.new @args
      end
      @options
    end

    def parsed_options
      @options.parsed
    end

    def response
      @response.body
    end

    def do_getPostStatus
      rpc = PresserXmlrpc.new @options.parsed
      result = rpc.call_xmlrpc rpc.options_for_getPostStatus
      result
    end

    def get_post postid
      rpc = PresserXmlrpc.new @options.parsed
      struct = rpc.get_post postid
    end

    def delete_post postid
      rpc = PresserXmlrpc.new @options.parsed
      rpc.delete_post postid
    end

    def run

      # if @options.parsed.use_config_file
      #   load_config_file @options.parsed.config_file_name
      # end

      rpc = PresserXmlrpc.new @options.parsed

      if @options.parsed.upload_file
        puts rpc.upload_file @options.parsed.file_to_upload
      end

      if @options.parsed.post_file
        filename = @options.parsed.file_to_post

        postid = rpc.post_file filename
        struct = rpc.get_post postid

        File.open(filename, "w") { |file| file.puts struct.to_s }

        puts postid
      end

      if @options.parsed.make_config_file
        puts @options.save_to_file
      end

      if @options.parsed.delete_post
        delete_post @options.parsed.postid
      end

      if @options.parsed.show_config
        puts @options.to_yaml
      end
    end

  end
end

