#tzx：lovingly stolen……这个表达给跪……
#
#   -   这个涉及到一个知识点：ruby 可以热更新自带的组件，
#   -   Hash#deep_merge 来扩展 Hash，
#   -   Hash#pluralized_array（看 Hash 有没有这两个 key，返回个 Array），
#   -   Hash#symbolize_keys!（把 string 换成 sym，因为 ruby 社区）
#   -   Hash#symbolize_keys 这个是非 intrusive 的，实际上 dup 了再入侵的……
#   -   Enumerable#glob_include?
#   -   Date#xmlschema，生成一个时间字符串
#   -   File#read_with_options，< 1.9 的 Ruby 没有 opt 选项，直接忽略，后来的，就用默认的

class Hash
  # Merges self with another hash, recursively.
  #
  # This code was lovingly stolen from some random gem:
  # http://gemjack.com/gems/tartan-0.1.1/classes/Hash.html
  #
  # Thanks to whoever made it.
  def deep_merge(hash)
    target = dup                                                    #tzx：注意这里是 dup 而不是 target = self，一定要拷贝一份。
                                                                    # 这个函数式可重入的。不修改自己。

    hash.keys.each do |key|
      if hash[key].is_a? Hash and self[key].is_a? Hash
        target[key] = target[key].deep_merge(hash[key])             #tzx: 全部操作到了 dup 上。递归。
        next
      end

      target[key] = hash[key]
    end

    target
  end

  # Read array from the supplied hash favouring the singular key
  # and then the plural key, and handling any nil entries.
  #   +hash+ the hash to read from
  #   +singular_key+ the singular key
  #   +plural_key+ the plural key
  #
  # Returns an array
  def pluralized_array(singular_key, plural_key)
    hash = self
    if hash.has_key?(singular_key)
      array = [hash[singular_key]] if hash[singular_key]
    elsif hash.has_key?(plural_key)
      case hash[plural_key]
      when String
        array = hash[plural_key].split                  # 按照空格 split
      when Array
        array = hash[plural_key].compact                # 去掉里面的 nil，文档：[compact (Array) - APIdock](https://apidock.com/ruby/Array/compact)
      end
    end
    array || []
  end

  def symbolize_keys!
    keys.each do |key|
      self[(key.to_sym rescue key) || key] = delete(key)            # delete(key) 应该返回了这个 value，然后给它重新帮顶一下。
    end
    self
  end

  def symbolize_keys
    dup.symbolize_keys!                                             # dup 一下再 inplace……
  end
end

# Thanks, ActiveSupport!
class Date
  # Converts datetime to an appropriate format for use in XML
  def xmlschema                                                     # 兼容性，类似 JS 的 shim。
    strftime("%Y-%m-%dT%H:%M:%S%Z")
  end if RUBY_VERSION < '1.9'                                       #tzx：看来工程实践出真知啊！Ruby style guide 里面说不要这样来着。
end

module Enumerable
  # Returns true if path matches against any glob pattern.
  # Look for more detail about glob pattern in method File::fnmatch.
  def glob_include?(e)
    any? { |exp| File.fnmatch?(exp, e) }
  end
end

# Ruby 1.8's File.read don't support option.
# read_with_options ignore optional parameter for 1.8,
# and act as alias for 1.9 or later.
#tzx:
#   -   这个也太……
#   -   读取，如果版本小于 1.9 直接不看 opts，如果高于，用 IO#read
#       -   [Class: IO (Ruby 2.2.0)](http://ruby-doc.org/core-2.2.0/IO.html)
#       -   read(name, [length [, offset]] [, opt] ) → string
#       -   The options hash accepts the following keys:
#           -   encoding
#           -   mode
#           -   open_args: array of strings
#       -   Example
#
#           ```ruby
#           IO.read("testfile")              #=> "This is line one\nThis is line two\nThis is line three\nAnd so on...\n"
#           IO.read("testfile", 20)          #=> "This is line one\nThi"
#           IO.read("testfile", 20, 10)      #=> "ne one\nThis is line "
#           IO.read("binfile", mode: "rb")   #=> "\xF7\x00\x00\x0E\x12"
#           ```
class File
  if RUBY_VERSION < '1.9'
    def self.read_with_options(path, opts = {})
      self.read(path)
    end

    def self.realpath(filename)
      Pathname.new(filename).realpath.to_s
    end
  else
    def self.read_with_options(path, opts = {})
      self.read(path, opts)
    end
  end
end
