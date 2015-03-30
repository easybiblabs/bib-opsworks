gem 'minitest'

require 'minitest/autorun'
require 'bib/opsworks/google'

class GoogleTest < Minitest::Test

  def test_publish_deployment_user
    google = Bib::Opsworks::Google.new

    deploy_data = { 'deploying_user' => 'arn:aws:iam::123456:user/gemtest', 'scm' => { 'revision' => 'rev1' } }
    app_name = 'unittest'

    result = google.prepare_publishing_data(app_name, deploy_data)
    expected = {"deployment[app_name]"=>"unittest", "deployment[user]"=>"gemtest", "deployment[revision]"=>"rev1"}
    assert_equal(expected, result)
  end

  def test_publish_deployment_nouser
    google = Bib::Opsworks::Google.new

    deploy_data = { 'scm' => { 'revision' => 'rev1' } }
    app_name = 'unittest'

    result = google.prepare_publishing_data(app_name, deploy_data)
    expected = {"deployment[app_name]"=>"unittest", "deployment[user]"=>"opsworks", "deployment[revision]"=>"rev1"}
    assert_equal(expected, result)
  end

  def test_publish_deployment
   google = Bib::Opsworks::Google.new

    deploy_data = { 'deploying_user' => 'arn:aws:iam::123456:user/gemtest', 'scm' => { 'revision' => 'rev1' } }
    app_name = 'unittest'
    google_ident = 'UA-1869721-12'
    result = google.publish_deployment(app_name, deploy_data, google_ident)
    expected = true
    assert_equal(expected, result)
  end
end
