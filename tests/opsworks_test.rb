gem 'minitest'

require 'minitest/autorun'
require 'bib/opsworks'

class OpsworksTest < Minitest::Test

  def test_version
    assert_equal("0.0.4", BibOpsworks.new.version)
  end
end
