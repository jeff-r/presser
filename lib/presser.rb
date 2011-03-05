require_relative 'presser_opts'
require 'net/http'
require 'xmlrpc/client'
require_relative 'presser_xmlrpc'
require 'fileutils'

module Presser

  class Presser
    def initialize(args, filename=nil)
      if filename
        @options = PresserOpts.from_file filename
        @options.parse args
      else
        @options = PresserOpts.new args
      end

      self
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


    def run
      rpc = PresserXmlrpc.new @options.parsed

      if @options.parsed.upload_file
        puts "Upload: #{@options.parsed.inspect}"
        puts rpc.upload_file @options.parsed.file_to_upload
        # puts rpc.file_type_from_name @options.parsed.file_to_upload
      end

      if @options.parsed.post_file
        filename = @options.parsed.file_to_post

        postid = rpc.post_file filename
       # rpc.save_post_to_file postid, filename

        puts postid
      end

      if @options.parsed.make_config_file
        puts @options.save_to_file
      end
    end

  end
end

