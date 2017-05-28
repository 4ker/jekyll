#tzx: 啥事 attr_accessor
#
#   -   attr_reader :name
#   -   attr_writer :name
#   -   两个加起来，就是 attr_acessor，这样 self 下就有 @name 这个变量了。
#
#   refs and see also
#
#   -   [What is attr_accessor in Ruby? - Stack Overflow](https://stackoverflow.com/questions/4370960/what-is-attr-accessor-in-ruby)
#   -   [Why use Ruby's attr_accessor, attr_reader and attr_writer? - Stack Overflow](https://stackoverflow.com/questions/5046831/why-use-rubys-attr-accessor-attr-reader-and-attr-writer)
#
#   这个文件就是实现了一个带 level 的 logger。

module Jekyll
  class Stevenson
    attr_accessor :log_level

    DEBUG  = 0
    INFO   = 1
    WARN   = 2
    ERROR  = 3

    # Public: Create a new instance of Stevenson, Jekyll's logger
    #
    # level - (optional, integer) the log level
    #
    # Returns nothing
    def initialize(level = INFO)
      @log_level = level
    end

    # Public: Print a jekyll debug message to stdout
    #
    # topic - the topic of the message, e.g. "Configuration file", "Deprecation", etc.
    # message - the message detail
    #
    # Returns nothing
    def debug(topic, message = nil)
      $stdout.puts(message(topic, message)) if log_level <= DEBUG                       # 数字越大，越严重。$stdout，为啥这个 message 没有被 shadow？
    end

    # Public: Print a jekyll message to stdout
    #
    # topic - the topic of the message, e.g. "Configuration file", "Deprecation", etc.
    # message - the message detail
    #
    # Returns nothing
    def info(topic, message = nil)
      $stdout.puts(message(topic, message)) if log_level <= INFO
    end

    # Public: Print a jekyll message to stderr
    #
    # topic - the topic of the message, e.g. "Configuration file", "Deprecation", etc.
    # message - the message detail
    #
    # Returns nothing
    def warn(topic, message = nil)
      $stderr.puts(message(topic, message).yellow) if log_level <= WARN
    end

    # Public: Print a jekyll error message to stderr
    #
    # topic - the topic of the message, e.g. "Configuration file", "Deprecation", etc.
    # message - the message detail
    #
    # Returns nothing
    def error(topic, message = nil)
      $stderr.puts(message(topic, message).red) if log_level <= ERROR
    end

    # Public: Print a Jekyll error message to stderr and immediately abort the process
    #
    # topic - the topic of the message, e.g. "Configuration file", "Deprecation", etc.
    # message - the message detail (can be omitted)
    #
    # Returns nothing
    def abort_with(topic, message = nil)
      error(topic, message)
      abort
    end

    # Public: Build a Jekyll topic method
    #
    # topic - the topic of the message, e.g. "Configuration file", "Deprecation", etc.
    # message - the message detail
    #
    # Returns the formatted message
    def message(topic, message)
      formatted_topic(topic) + message.to_s.gsub(/\s+/, ' ')                #tzx：多个连续 whitespaces 变成一个。
    end

    # Public: Format the topic
    #
    # topic - the topic of the message, e.g. "Configuration file", "Deprecation", etc.
    #
    # Returns the formatted topic statement
    def formatted_topic(topic)
      "#{topic} ".rjust(20)                                                 #tzx：右对齐，填充空格。
    end
  end
end
