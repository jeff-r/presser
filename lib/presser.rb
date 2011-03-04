require_relative 'presser_opts'
require 'net/http'
require 'xmlrpc/client'
require_relative 'presser_xmlrpc'
require 'fileutils'

module Presser

  class Presser
    def initialize(args)
      @options = PresserOpts.new args
      @presserOpts = PresserOpts.new args
      self
    end

    def parsed_options
      @options.parsed
    end

    def response
      @response.body
    end

    def do_getPostStatus
      rpc = PresserXmlrpc.new parsed
      result = rpc.call_xmlrpc rpc.options_for_getPostStatus
      # puts result.inspect
      result
    end


    def run
      rpc = PresserXmlrpc.new parsed

      if @options.parsed.upload_file
        puts rpc.upload_file @options.parsed.file_to_upload
        # puts rpc.file_type_from_name @options.parsed.file_to_upload
      end

      if @options.parsed.post_file
        puts rpc.post_file @options.parsed.file_to_post
      end

      if @options.make_config_file
        puts @presserOpts.create_config_file
      end

        options.make_config_file = true
        options.config_file_name = filename.strip
    end

  end
end

