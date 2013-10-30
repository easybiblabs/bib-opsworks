require 'fileutils'
require 'logger'

module Bib
  module Opsworks
    class Composer

      def copy_vendor(release_path, deploy_user)

        log_file = File.new('/tmp/test-copy-vendor.log', 'a')
        log = Logger.new(log_file, 'weekly')
        $stderr = log_file
        $stdout = log_file
        
        
        app_current = ::File.expand_path("#{release_path}/../../current")
        vendor_dir  = "#{app_current}/vendor"

        deploy_username  = deploy_user['user']
        deploy_group     = deploy_user['group']

        release_vendor = "#{release_path}/vendor"
        
        log.debug("Copy Vendor: Copying from #{vendor_dir} to #{release_vendor}")        
        result = ::FileUtils.cp_r vendor_dir, release_vendor, :verbose => true if ::File.exists?(vendor_dir)
        
        log.debug("Chown Vendor #{release_vendor} to #{deploy_username}.#{deploy_group}")
        result = ::FileUtils.chown_R deploy_username, deploy_group, release_vendor, :verbose => true if ::File.exists?(release_vendor)
      end
    end
  end
end
