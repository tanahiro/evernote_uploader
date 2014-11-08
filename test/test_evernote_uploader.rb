root_dir = "#{__dir__}/../"
require "#{root_dir}/test/minitest_helper"

class EvernoteUploader
  def initialize
    @options = {}
  end
end

class TestEvernoteUploader < MiniTest::Unit::TestCase

  def test_that_it_has_a_version_number
    refute_nil ::EvernoteUploader::VERSION
  end

  def test_check_evernote_token
    e = EvernoteUploader.new
    
    assert_raises(EvernoteUploader::TokenError) {
      e.instance_eval{ check_evernote_token }
    }
  end
end

