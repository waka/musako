require 'yaml'

module Musako
  class Configuration < Hash

    # Default options.
    DEFAULTS = {
      source:      Dir.pwd,
      destination: File.join(Dir.pwd, 'target'),
      views:       'views',
      assets:      'assets',
      posts:       'posts',

      port:        '3333',
      host:        '0.0.0.0',
      verbose:     true,
      detach:      false,

      author:      'nobody',
      title:       'my notes',
      description: 'my tech notes',
      timezone:    'UTC',
      site_url:    'http://pages.github.com'
    }

    # load YAML file.
    def read_config_file
      c = clone

      config = YAML.load_file(File.join(DEFAULTS[:source], "config.yml"))
      unless config.is_a? Hash
        raise ArgumentError.new("Configuration file: invalid #{file}")
      end
      c.merge(config)
    rescue SystemCallError
      raise LoadError, "Configuration file: not found #{file}"
    end

    def symbolize_keys
      inject({}) do |options, (key, value)|
        value = value.symbolize_keys if defined?(value.symbolize_keys)
        options[(key.to_sym rescue key) || key] = value
        options
      end
    end
  end
end
