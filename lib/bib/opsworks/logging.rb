require 'logger'

module Bib
  module Opsworks
    module Logging
      def log
        if(defined?(Chef::Log))
          Chef::Log
        else
          unless(@logger)
            require 'logger'
            @logger = Logger.new(STDOUT)
          end
          @logger
        end
      end
    end
  end
end