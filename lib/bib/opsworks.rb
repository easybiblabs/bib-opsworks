require 'bib/opsworks/composer'
require 'bib/opsworks/newrelic'
require 'bib/opsworks/version'

class BibOpsworks

  def initialize
  end
  
  def copy_composer(release_path, deploy_user)
    composer = Bib::Opsworks::Composer.new
    composer.copy_vendor(release_path, deploy_user)
  end

  def newrelic_publish_deployment(app_name, deploy_data, newrelic_api_key)
    newrelic = Bib::Opsworks::Newrelic.new
    newrelic.publish_deployment(app_name, deploy_data, newrelic_api_key)
  end

  def version
    Bib::Opsworks::VERSION
  end
end
