require 'yaml'

module Presser
  class PresserYaml
    def initialize opts
      puts opts.parsed.to_yaml
    end
  end
end

