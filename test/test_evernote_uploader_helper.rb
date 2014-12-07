ROOT_DIR = "#{__dir__}/../"
require "#{ROOT_DIR}/test/minitest_helper"

require "#{ROOT_DIR}/lib/evernote_uploader/helper"

class TestEvernoteUploader < MiniTest::Unit::TestCase
  include EvernoteUploaderHelper

  def test_detect_mime_type
    assert_equal("application/pdf", detect_mime_type("foo.pdf"))
    assert_equal("application/pdf", detect_mime_type("foo.PDF"))
    assert_equal("application/epub+zip", detect_mime_type("foo.epub"))
    assert_equal("application/x-mobipocket-ebook", detect_mime_type("foo.mobi"))
    assert_equal("image/jpeg", detect_mime_type("foo.jpg"))
    assert_equal("image/png", detect_mime_type("foo.png"))

    assert_raises(FileTypeError) { detect_mime_type("foo.bar") }
  end

  def test_create_note
    expected_content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>
  <en-media type="image/png" hash = "a54fe8bcd146e20a8a5742834558543c"/>
</en-note>
EOF
    note = create_note({}, ["#{ROOT_DIR}/test/enlogo.png"])

    assert_equal(expected_content, note.content)
    assert_equal("enlogo", note.title)

  end
end

