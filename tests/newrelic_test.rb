gem 'minitest'

require 'minitest/autorun'
require 'bib/opsworks/newrelic'

class NewrelicTest < Minitest::Test
  
  def test_publish_deployment
    newrelic = Bib::Opsworks::Newrelic.new()
    
    newrelic_api_key = '#'
    deploy_data = { 'deploying_user' => 'gemtest', 'scm' => { 'revision' => 'rev1' } }
    app_name = 'unittest'
    
    result = newrelic.publish_deployment(app_name, deploy_data, newrelic_api_key)
    assert_equal(true, result)
  end
end
