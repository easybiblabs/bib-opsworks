require 'bib/opsworks/composer'
require 'bib/opsworks/newrelic'
require 'bib/opsworks/version'

class BibOpsworks

  def copy_composer(release_path, deploy_user)
    run "echo My very last attempt to get sth in the logs"
    composer = Bib::Opsworks::Composer.new
    composer.copy_vendor(release_path, deploy_user)
  end

  def newrelic_publish_deployment(app_name, deploy_data, newrelic_api_key)
    run "echo publish deployment"
    newrelic = Bib::Opsworks::Newrelic.new
    newrelic.publish_deployment(app_name, deploy_data, newrelic_api_key)
  end

  def version
    Bib::Opsworks::VERSION
  end
end
