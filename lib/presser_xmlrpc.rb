require 'xmlrpc/client'
require_relative 'local_file'
require_relative 'blog_post'
require 'presser_doc'

module Presser

  class PresserXmlrpc

    def initialize(opts)
      @opt = opts
    end

    def call_xmlrpc(opts)
      # puts "call_xmlrpc: opts = #{opts}"
      server = XMLRPC::Client.new2(opts[:url])
      result = server.call(opts[:method], opts[:options])
    end

    def blog_id
      # Return the id for the first blog
      @blogid ||= getUsersBlogs[0]["blogid"]
      @blogid
    end

    def getUsersBlogs
      options = { :url => @opt.url, :method => "wp.getUsersBlogs", 
                  :options => [@opt.username, @opt.password] }
      call_xmlrpc options
    end
    def getPostStatusList
      options = { :url => @opt.url, :method => "wp.getPostStatusList", 
                  :options => [blog_id, @opt.username, @opt.password] }
      call_xmlrpc options
    end
    def getTags
      options = { :url => @opt.url, :method => "wp.getTags", 
                  :options => [blog_id, @opt.username, @opt.password] }
      call_xmlrpc options
    end
    def getRecentPosts
      options = { :url => @opt.url, :method => "metaWeblog.getRecentPosts", 
                  :options => [blog_id, @opt.username, @opt.password] }
      result = call_xmlrpc options
      result
    end
    def getPageList
      options = { :url => @opt.url, :method => "wp.getPageList", 
                  :options => [blog_id, @opt.username, @opt.password] }
      result = call_xmlrpc options
      result
    end

    def upload_file filename
      struct = { 
            "name" => File.basename(filename),
            "type" => file_type_from_name(filename),
            "bits" => encode64(filename),
            "overwrite" => false
            }
      options = { :url => @opt.url, :method => "wp.uploadFile", 
                  :options => [blog_id, @opt.username, @opt.password, struct] }
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

    def post_file(filename, publish = true)
      bp = BlogPost.from_filename filename

      struct = { 
            "title"       => bp.title,
            "link"        => bp.link,
            "categories"  => [],
            #"categories"  => bp.categories,
      #      "postid"      => bp.postid,
            "post_status" => bp.post_status,
            "description" => bp.body
            }
      if bp.postid == ""
        options = { :url => @opt.url, :method => "metaWeblog.newPost", 
                    :options => [blog_id, @opt.username, @opt.password,
                    struct, publish] }
      else
        # struct["postid"] = bp.postid
        options = { :url => @opt.url, :method => "metaWeblog.editPost", 
                    :options => [bp.postid.to_i, @opt.username, @opt.password, struct, publish] }
      end
      postid = call_xmlrpc options
      postid
    end

    # This returns a PresserDoc with the post contents
    # I've put a sample of the struct returned by wordpress at the end of this file
    def get_post(postid)
      options = { :url => @opt.url, :method => "metaWeblog.getPost", 
                  :options => [postid, @opt.username, @opt.password] }
      
      struct = call_xmlrpc options
      doc = PresserDoc.new struct["title"], struct["link"], struct["description"]
      doc.categories  = struct["categories"]
      doc.postid      = struct["postid"]
      doc.post_status = struct["post_status"]
      doc
    end

    def delete_post(postid)
      options = { :url => @opt.url, :method => "blogger.deletePost", 
                  :options => ["", postid, @opt.username, @opt.password, ""] }
      
      result = call_xmlrpc options
      result
    end

  end
end

# Struct returned by metaWeblog.getPost:
#  {
#    "dateCreated"=>#<XMLRPC::DateTime:0x00000100d96d80 @year=2011, @month=3, @day=5, @hour=2, @min=40, @sec=4>, 
#    "userid"=>"1", 
#    "postid"=>119, 
#    "description"=>"This is the body\nof the file.\n\nThis is [a link](http://www.google.com).", 
#    "title"=>"Put your title here", 
#    "link"=>"http://wordpress/wp/?p=119", 
#    "permaLink"=>"http://wordpress/wp/?p=119", 
#    "categories"=>["Uncategorized"], 
#    "mt_excerpt"=>"", 
#    "mt_text_more"=>"", 
#    "mt_allow_comments"=>1, 
#    "mt_allow_pings"=>1, 
#    "mt_keywords"=>"", 
#    "wp_slug"=>"put-your-title-here-7", 
#    "wp_password"=>"", 
#    "wp_author_id"=>"1", 
#    "wp_author_display_name"=>"jeff", 
#    "date_created_gmt"=>#<XMLRPC::DateTime:0x00000100db5ac8 @year=2011, @month=3, @day=5, @hour=2, @min=40, @sec=4>, 
#    "post_status"=>"publish", 
#    "custom_fields"=>[{"id"=>"180", "key"=>"_encloseme", "value"=>"1"}], 
#    "wp_post_format"=>"standard", 
#    "sticky"=>false
#  }
# 

