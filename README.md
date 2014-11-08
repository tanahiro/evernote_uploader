# EvernoteUploader

Upload files to Evernote

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'evernote_uploader'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install evernote_uploader

## Usage
Get a developer token from https://www.evernote.com/api/DeveloperToken.action,
and store the key in `~/.evernote-token`.

### As command line tool

```
evernote_uploader [options] <files>
  options
    -n, --notebook NOTEBOOK          Name of notebook (default: web clip)
    -t, --title TITLE                Title of the note
    --token TOKEN                    Token for evernote or filename
    --tags TAGS                      Tags
```

If multiple files are given, the all files are attached to a same note.

## Contributing
1. Fork it ( https://github.com/[my-github-username]/evernote_uploader/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

