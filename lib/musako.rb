# Require all files in directory.
def require_all(path)
  glob = File.join(File.dirname(__FILE__), path, '*.rb')
  Dir[glob].each do |f|
    require f
  end
end

# rubygems
require 'rubygems'

# stdlib
require 'fileutils'

# internal
require "musako/version"
require "musako/configuration"
require "musako/renderer"

require_all "musako/cli"
require_all "musako/renderers"

# end point
module Musako
  def self.configuration(options = {})
    return @config if @config

    config = Configuration[Configuration::DEFAULTS]
    config = config.read_config_file
    config = config.merge(options).symbolize_keys

    ENV['TZ'] = config[:timezone]
    @config = config
    @config
  end

  def self.source_path
    config = configuration
    config[:source]
  end

  def self.destination_path
    config = configuration
    config[:destination]
  end

  def self.views_path
    config = configuration
    File.join(config[:source], config[:views])
  end

  def self.posts_path
    config = configuration
    File.join(config[:source], config[:posts])
  end

  def self.assets_path
    config = configuration
    File.join(config[:source], config[:assets])
  end
end
