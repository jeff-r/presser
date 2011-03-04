require 'xmlrpc/client'
require_relative 'local_file'
require_relative 'blog_post'

module Presser

  class PresserXmlrpc

    def initialize(opts)
      @opts = opts
    end

    def call_xmlrpc(opts)
      # puts "opts: #{opts.inspect}"
      server = XMLRPC::Client.new2(opts[:url])
      result = server.call(opts[:method], opts[:options])
    end

    def blog_id
      # Return the id for the first blog
      @blogid ||= getUsersBlogs[0]["blogid"]
      # puts "Blogid = #{@blogid}"
      @blogid
    end

    def getUsersBlogs
      options = { :url => @opts.url, :method => "wp.getUsersBlogs", 
                  :options => [@opts.username, @opts.password] }
      call_xmlrpc options
    end
    def getPostStatusList
      options = { :url => @opts.url, :method => "wp.getPostStatusList", 
                  :options => [blog_id, @opts.username, @opts.password] }
      call_xmlrpc options
    end
    def getTags
      options = { :url => @opts.url, :method => "wp.getTags", 
                  :options => [blog_id, @opts.username, @opts.password] }
      call_xmlrpc options
    end
    def getRecentPosts
      options = { :url => @opts.url, :method => "metaWeblog.getRecentPosts", 
                  :options => [blog_id, @opts.username, @opts.password] }
      result = call_xmlrpc options
      # puts result[0].inspect
      result
    end
    def getPageList
      options = { :url => @opts.url, :method => "wp.getPageList", 
                  :options => [blog_id, @opts.username, @opts.password] }
      result = call_xmlrpc options
      # puts result.inspect
      result
    end

    def newPost
      doc = PresserDoc.new
      struct = doc.new_doc
      struct = { 
            "title" => "the shiny new title",
            "link"  => "the missing link",
            "description" => "the floral description"
            }
      publish = true
      options = { :url => @opts.url, :method => "metaWeblog.newPost", 
                  :options => [blog_id, @opts.username, @opts.password,
                  struct, publish] }
      result = call_xmlrpc options
      # puts result.inspect
      result
    end

    def upload_file filename
      struct = { 
            "name" => File.basename(filename),
            "type" => file_type_from_name(filename),
            "bits" => encode64(filename),
            "overwrite" => false
            }
      options = { :url => @opts.url, :method => "wp.uploadFile", 
                  :options => [blog_id, @opts.username, @opts.password, struct] }
      result = call_xmlrpc options
      result = result["url"]
    end

    def file_type_from_name filename
      ext = File.extname(filename).sub(/\./, '').downcase
      
      # http://www.w3schools.com/media/media_mimeref.asp
      types = {
        "txt"  => "text/plain",
        "jpg"  => "image/jpeg",
        "jpeg" => "image/jpeg",
        "png"  => "image/png",
        "gif"  => "image/gif",
        "tif"  => "image/tif",
        "tiff" => "image/tiff",
        "pdf"  => "application/pdf",
        "doc"  => "application/msword",
        "rtf"  => "application/rtf",
        "xls"  => "application/vnd.ms-excel",
        "mp3"  => "audo/mpeg"
      }
      types[ext]
    end

    def encode64 filename
      # http://perfectionlabstips.wordpress.com/2008/11/20/encoding-files-to-base64-representation-directly-from-command-line/
      # ruby -e 'print [IO.read(File.join(Dir.pwd, ARGV[0]))].pack("m")'
      # XMLRPC::Base64.new([IO.read(filename)].pack("m0"))
      # http://blog.bitcrowd.net/upload-a-file-to-a-wordpress-blog-via-xml-rpc-wp-uploadfile/
      XMLRPC::Base64.new(File.open(filename).read)
    end

    def post_file filename
      bp = BlogPost.from_filename filename

      # puts "bp: #{bp.dumpself}"

      struct = { 
            "title" => bp.title,
            "link"  => "the missing link",
            "description" => bp.body
            }
      publish = true
      options = { :url => @opts.url, :method => "metaWeblog.newPost", 
                  :options => [blog_id, @opts.username, @opts.password,
                  struct, publish] }
      result = call_xmlrpc options
      # puts result.inspect
      result
    end

  end
end

