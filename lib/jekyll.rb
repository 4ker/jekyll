#tzx: "$:" 类似 $PATH，unshift 是 prepend 当前目录。
#
#   $: is just a shortcut for $LOAD_PATH. __FILE__ is the relative path to the
#   script. This adds the current script directory to the load path.
#
#   source: [ruby $:.unshift File.dirname(__FILE__) - Stack Overflow](https://stackoverflow.com/questions/9238367/ruby-unshift-file-dirname-file/9238388)
$:.unshift File.dirname(__FILE__) # For use/testing when no gem is installed

# 传入一个路径，然后把下面的 rb 文件都拿到，然后 require 这个文件
# Require all of the Ruby files in the given directory.
#
# path - The String relative path from here to the directory.
#
# Returns nothing.
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
require 'time'
require 'safe_yaml'
require 'English'
require 'pathname'

# 3rd party
require 'liquid'
require 'maruku'
require 'colorator'
require 'toml'

# internal requires
# 每个 require 对应一个 rb 文件
# 如 jekyll/core_ext 对应 "jekyll/core_ext.rb"
require 'jekyll/core_ext'
require 'jekyll/stevenson'                              # 这是 logger，带 level。
require 'jekyll/deprecator'
require 'jekyll/configuration'
require 'jekyll/site'
require 'jekyll/convertible'
require 'jekyll/url'
require 'jekyll/layout'
require 'jekyll/page'
require 'jekyll/post'
require 'jekyll/excerpt'
require 'jekyll/draft'
require 'jekyll/filters'
require 'jekyll/static_file'
require 'jekyll/errors'
require 'jekyll/related_posts'
require 'jekyll/cleaner'
require 'jekyll/entry_filter'

# extensions
require 'jekyll/plugin'
require 'jekyll/converter'
require 'jekyll/generator'
require 'jekyll/command'

require_all 'jekyll/commands'
require_all 'jekyll/converters'
require_all 'jekyll/converters/markdown'
require_all 'jekyll/generators'
require_all 'jekyll/tags'

SafeYAML::OPTIONS[:suppress_warnings] = true

module Jekyll
  VERSION = '1.5.1'

  #tzx: 这里很有哲学啊！配置文件如何 overide，总是有顺序的。
  # Public: Generate a Jekyll configuration Hash by merging the default
  # options with anything in _config.yml, and adding the given options on top.
  #
  # override - A Hash of config directives that override any options in both
  #            the defaults and the config file. See Jekyll::Configuration::DEFAULTS for a
  #            list of option names and their defaults.
  #
  # Returns the final configuration Hash.
  def self.configuration(override)
    config = Configuration[Configuration::DEFAULTS]
    override = Configuration[override].stringify_keys
    config = config.read_config_files(config.config_files(override))

    # Merge DEFAULTS < _config.yml < override
    config = config.deep_merge(override).stringify_keys
    set_timezone(config['timezone']) if config['timezone']

    config
  end

  # Static: Set the TZ environment variable to use the timezone specified
  #
  # timezone - the IANA Time Zone
  #
  # Returns nothing
  def self.set_timezone(timezone)
    ENV['TZ'] = timezone                                # 这样可以获取/设置环境变量。
  end

  def self.logger
    @logger ||= Stevenson.new                           #tzx：get or init—then-get。
  end

  # Get a subpath without any of the traversal nonsense.
  #
  # Returns a pure and clean path
  def self.sanitized_path(base_directory, questionable_path)                # 正则化目录。
    clean_path = File.expand_path(questionable_path, "/")
    clean_path.gsub!(/\A\w\:\//, '/')
    unless clean_path.start_with?(base_directory)
      File.join(base_directory, clean_path)
    else
      clean_path
    end
  end
end
