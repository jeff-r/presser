# Keep sensitive data (oh, cute ... sensitive!) out of git
module Presser
  class NoGit
    def self.username 
      "jeff"
    end
    def self.password 
      "calvin"
    end
    def self.url
      "http://wordpress/wp/xmlrpc.php"
    end
  end
end
