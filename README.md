# musako

Simple generator of static site.

## Installation

Add this line to your application's Gemfile:

    gem 'musako'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install musako

## Usage

First, please see help.

    $ musako -h

Create directories from template (only once).

    $ musako generate

Write your post, and build.
(Filename rule: {YYYYMMDD-hoge.md}

And can edit "config.yml" for site title and description.

    $ touch posts/20140101-blurblur.md
    $ musako build

Up local httpd.

    $ musako server -P 3000

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
