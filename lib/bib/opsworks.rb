require 'bib/opsworks/composer'
require 'bib/opsworks/newrelic'
require 'bib/opsworks/qafoo'
require 'bib/opsworks/google'
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
  
  def qafoo_publish_deployment(app_name, deploy_data, qafoo_api_key)
      qafoo = Bib::Opsworks::Qafoo.new
      qafoo.publish_deployment(app_name, deploy_data, qafoo_api_key)
  end

  def google_publish_deployment(app_name, deploy_data, google_ident)
    google = Bib::Opsworks::Google.new
    google.publish_deployment(app_name, deploy_data, google_ident)
  end

  def version
    Bib::Opsworks::VERSION
  end
end
