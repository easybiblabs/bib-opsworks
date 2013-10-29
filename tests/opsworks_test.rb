gem 'minitest'

require 'minitest/autorun'
require 'bib/opsworks'

class OpsworksTest < Minitest::Test

  def test_version
    bib = BibOpsworks.new({})
    assert_equal("0.0.2", bib.version())
  end
end
