require 'fileutils'
require 'stringio'
require 'bib/opsworks/logging'

module Bib
  module Opsworks
    class Composer
      include Logging

      def copy_vendor(release_path, deploy_user)
        app_current = ::File.expand_path("#{release_path}/../../current")
        vendor_dir  = "#{app_current}/vendor"

        deploy_username  = deploy_user['user']
        deploy_group     = deploy_user['group']

        release_vendor = "#{release_path}/vendor"

        if ::File.exist?(vendor_dir)
          fileutils_output = StringIO.new
          ::FileUtils.fileutils_output = fileutils_output
          log.debug("Copy Vendor: Copying from #{vendor_dir} to #{release_vendor}")
          ::FileUtils.cp_r vendor_dir, release_vendor, verbose: true
          log.debug(fileutils_output.string)
        else
          log.info("Vendor dir #{vendor_dir} does not exist")
        end

        if ::File.exist?(release_vendor)
          fileutils_output = StringIO.new
          ::FileUtils.fileutils_output = fileutils_output
          log.debug("Chown Vendor #{release_vendor} to #{deploy_username}.#{deploy_group}")
          ::FileUtils.fileutils_output = fileutils_output
          result = ::FileUtils.chown_R deploy_username, deploy_group, release_vendor, verbose: true
          log.debug(fileutils_output.string)
        else
          log.info("Release vendor dir #{release_vendor} does not exist")
        end
        result
      end
    end
  end
end

module FileUtils
  class << self
    attr_writer :fileutils_output
  end
end
