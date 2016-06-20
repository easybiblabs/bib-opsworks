gem 'minitest'

require 'minitest/autorun'
require 'bib/opsworks/qafoo'

class QafooTest < Minitest::Test
  def test_publish_deployment_user
    qafoo = Bib::Opsworks::Qafoo.new

    deploy_data = { 'deploying_user' => 'arn:aws:iam::123456:user/gemtest', 'scm' => { 'revision' => 'rev1' } }
    app_name = 'unittest'

    scm_revision = deploy_data['scm']['revision']
    deployment_user = if deploy_data['deploying_user'].nil? || deploy_data['deploying_user'].empty?
                        'opsworks'
                      else
                        deploy_data['deploying_user'].split('/')[1]
                      end
    name_text = "#{scm_revision} by #{deployment_user}"

    result = qafoo.prepare_publishing_data(app_name, deploy_data)
    expected = {
      'name' => name_text,
      'environment' => 'unittest',
      'type' => 'release'
    }
    assert_equal(expected, result)
  end

  def test_publish_deployment_nouser
    qafoo = Bib::Opsworks::Qafoo.new

    deploy_data = { 'scm' => { 'revision' => 'rev1' } }
    app_name = 'unittest'

    scm_revision = deploy_data['scm']['revision']
    deployment_user = if deploy_data['deploying_user'].nil? || deploy_data['deploying_user'].empty?
                        'opsworks'
                      else
                        deploy_data['deploying_user'].split('/')[1]
                      end
    name_text = "#{scm_revision} by #{deployment_user}"

    result = qafoo.prepare_publishing_data(app_name, deploy_data)
    expected = {
      'name' => name_text,
      'environment' => 'unittest',
      'type' => 'release'
    }
    assert_equal(expected, result)
  end
end
