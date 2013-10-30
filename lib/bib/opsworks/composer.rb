module Bib
  module Opsworks
    class Composer

      def copy_vendor(release_path, deploy_user)
        app_current = ::File.expand_path("#{release_path}/../../current")
        vendor_dir  = "#{app_current}/vendor"

        deploy_username  = deploy_user['user']
        deploy_group     = deploy_user['group']

        release_vendor = "#{release_path}/vendor"

        ::FileUtils.cp_r vendor_dir, release_vendor if ::File.exists?(vendor_dir)
        ::FileUtils.chown_R deploy_username, deploy_group, release_vendor if ::File.exists?(release_vendor)
      end
    end
  end
end
