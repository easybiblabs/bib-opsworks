require 'bib/opsworks/composer'
require 'bib/opsworks/newrelic'
require 'bib/opsworks/version'

class BibOpsworks
  def initialize(deploy_data)
    @deploy_data = deploy_data
  end

  def copy_composer(release_path)
    composer = Bib::Opsworks::Composer.new
    composer.copy_vendor(release_path, @deploy_data)
  end

  def newrelic_publish_deployment(app_name, newrelic_api_key)
    newrelic = Bib::Opsworks::Newrelic.new
    newrelic.publish_deployment(app_name, @deploy_data, newrelic_api_key)
  end

  def version
    Bib::Opsworks::VERSION
  end
end
