require_relative 'presser_opts'
require 'net/http'
require 'xmlrpc/client'
require_relative 'presser_xmlrpc'
require 'fileutils'

module Presser

  class Presser
    def initialize(args)
      @opts = PresserOpts.parse(args)
      self
    end

    def options
      @opts
    end

    def response
      @response.body
    end

    def do_getPostStatus
      rpc = PresserXmlrpc.new @opts
      result = rpc.call_xmlrpc rpc.options_for_getPostStatus
      # puts result.inspect
      result
    end


    def run
      rpc = PresserXmlrpc.new @opts

      if @opts.upload_file
        puts rpc.upload_file @opts.file_to_upload
        # puts rpc.file_type_from_name @opts.file_to_upload
      end

      if @opts.post_file
        puts rpc.post_file @opts.file_to_post
      end

    end

  end
end

