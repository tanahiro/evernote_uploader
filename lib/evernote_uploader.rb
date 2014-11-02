
require "digest/md5"
require "evernote-thrift"

root_dir = "#{__dir__}/../"
require "#{root_dir}/lib/evernote_uploader/version"
require "#{root_dir}/lib/evernote_uploader/helper"

class EvernoteUploader
  include EvernoteUploaderHelper

  EvernoteHost = "www.evernote.com"
  EvernoteUrl  = "https://#{EvernoteHost}/edam/user/"


  def initialize filenames, options
    @filenames = filenames
    @options   = options

    check_evernote_token

    evernote_api

    get_notebooks
    check_notebook

    @note = create_note(@options, @filenames)
  end

  def upload
    @note_store.createNote(@token, @note)
  end

  def check_evernote_token
    if File.exist?(File.expand_path(@options[:token]))
      filename = File.expand_path(@options[:token])
      @token = File.open(filename) {|f| f.gets }.chomp
    else
      @token = @options[:token]
    end
  end

  def evernote_api
    user_store_transport = Thrift::HTTPClientTransport.new(EvernoteUrl)
    user_store_protocol  = Thrift::BinaryProtocol.new(user_store_transport)
    @user_store          =
      Evernote::EDAM::UserStore::UserStore::Client.new(user_store_protocol)

    version_ok =
      @user_store.checkVersion("Evernote EDAMTest (Ruby)",
                              Evernote::EDAM::UserStore::EDAM_VERSION_MAJOR,
                              Evernote::EDAM::UserStore::EDAM_VERSION_MINOR)
    unless version_ok
      puts "Evernote API version not up-to-date"
      exit
    end
  end

  def get_notebooks
    note_store_url       = @user_store.getNoteStoreUrl(@token)
    note_store_transport = Thrift::HTTPClientTransport.new(note_store_url)
    note_store_protocol  = Thrift::BinaryProtocol.new(note_store_transport)
    @note_store          =
      Evernote::EDAM::NoteStore::NoteStore::Client.new(note_store_protocol)

  end

  def check_notebook
    notebooks = @note_store.listNotebooks(@token)
    note_names = notebooks.map {|nb| nb.name }

    unless note_names.include?(@options[:notebook])
      puts "Note book \"#{@options[:notebook]}\" doesn't exist -- exit"
      exit
    else
      index = note_names.index(@options[:notebook])
      @notebook = notebooks[index]
    end
  end
end

