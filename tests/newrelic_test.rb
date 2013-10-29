gem 'minitest'

require 'minitest/autorun'
require 'bib/opsworks/newrelic'

class NewrelicTest < Minitest::Test

  def test_publish_deployment
    newrelic = Bib::Opsworks::Newrelic.new()

    deploy_data = { 'deploying_user' => 'arn:aws:iam::123456:user/gemtest', 'scm' => { 'revision' => 'rev1' } }
    app_name = 'unittest'

    result = newrelic.prepare_publishing_data(app_name, deploy_data)
    assert_equal("deployment[app_name]=unittest&deployment[user]=gemtest&=deployment[revision]=rev1", result)
  end

  def test_publish_deployment_nouser
    newrelic = Bib::Opsworks::Newrelic.new()

    deploy_data = { 'scm' => { 'revision' => 'rev1' } }
    app_name = 'unittest'

    result = newrelic.prepare_publishing_data(app_name, deploy_data)
    assert_equal("deployment[app_name]=unittest&deployment[user]=opsworks&=deployment[revision]=rev1", result)
  end
end
