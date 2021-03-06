require 'mime/types'

module EvernoteUploaderHelper
  class FileTypeError < StandardError; end

  ##
  #  http://www.iana.org/assignments/media-types/media-types.xhtml
  def detect_mime_type filename
    extname = File.extname(filename).downcase.gsub(/\A\./, "")

    mime = MIME::Types.find do |type|
      type.extensions.any?(extname)
    end

    if mime
      return mime.to_s
    else
      raise FileTypeError, "Unknown file type: #{extname}"
    end
  end

  def create_note options, filenames, notebook = nil
    note       = Evernote::EDAM::Type::Note.new
    note.title = options[:title] || File.basename(filenames.first, ".*")

    note.tagNames     = options[:tags]
    if notebook
      note.notebookGuid = notebook.guid
    end

    note.resources = []
    note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>
EOF

    filenames.each {|filename|
      file_data = File.open(filename, "rb") {|f| f.read}
      hash_func = Digest::MD5.new
      
      data          = Evernote::EDAM::Type::Data.new
      data.size     = file_data.size
      data.bodyHash = hash_func.digest(file_data)
      data.body     = file_data

      resource            = Evernote::EDAM::Type::Resource.new
      resource.mime       = detect_mime_type(filename)
      resource.data       = data
      resource.attributes = Evernote::EDAM::Type::ResourceAttributes.new
      resource.attributes.fileName = filename

      hash_hex = hash_func.hexdigest(file_data)

      note.resources << resource

      note.content += "  <en-media type=\"#{resource.mime}\" "
      note.content += "hash = \"#{hash_hex}\"/>\n"
    }

    note.content += "</en-note>\n"

    return note
  end
end

