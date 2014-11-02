root_dir = "#{__dir__}/../"
require "#{root_dir}/test/minitest_helper"

class TestEvernoteUploader < MiniTest::Unit::TestCase
  def test_that_it_has_a_version_number
    refute_nil ::EvernoteUploader::VERSION
  end

  def test_detect_mime_type
  end
end

