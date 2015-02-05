gem 'minitest'

require 'minitest/autorun'
require 'bib/opsworks/composer'

class ComposerTest < Minitest::Test
  def setup
    @fixtures_path ||= Pathname.new(File.expand_path('../tmp-fixtures/', __FILE__)).tap do |path|
      FileUtils.mkdir_p path.to_s
    end

    @release_path = Pathname.new(File.expand_path('releases/123/', @fixtures_path))
    FileUtils.mkdir_p @release_path
    FileUtils.mkdir_p Pathname.new(File.expand_path('current/vendor/some-lib', @fixtures_path))
  end

  def teardown
    FileUtils.rm_rf @fixtures_path
  end

  def test_composer_copy
    composervendor = Bib::Opsworks::Composer.new

    # do not use www-data, or the test will fail on systems without that user
    deploy_user = { 'user' => Process.uid, 'group' => Process.gid }

    composervendor.copy_vendor(@release_path, deploy_user)
    assert_equal(true, ::File.exist?(File.expand_path('releases/123/vendor/some-lib', @fixtures_path)))
  end
end
