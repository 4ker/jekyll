#tzx：
#   -   多种 Markdown 解析器
#   -   @config 来配置 Markdown 解析器
#   -   setup 来 guard……
#   -   都是转化到 html

module Jekyll
  module Converters
    class Markdown < Converter
      safe true

      #tzx：设定了前后缀……pygments 是啥意思？……
      pygments_prefix "\n"
      pygments_suffix "\n"

      def setup
        return if @setup                            #tzx：guard，如果 setup 过了，就不要 setup 了。
        @parser = case @config['markdown']          #tzx：配置 Markdown 解析器
          when 'redcarpet'
            RedcarpetParser.new @config
          when 'kramdown'
            KramdownParser.new @config
          when 'rdiscount'
            RDiscountParser.new @config
          when 'maruku'
            MarukuParser.new @config
          else
            STDERR.puts "Invalid Markdown processor: #{@config['markdown']}"
            STDERR.puts "  Valid options are [ maruku | rdiscount | kramdown | redcarpet ]"
            raise FatalException.new("Invalid Markdown process: #{@config['markdown']}")
        end
        @setup = true
      end

      def matches(ext)
        rgx = '^\.(' + @config['markdown_ext'].gsub(',','|') +')$'      #tzx？？
        ext =~ Regexp.new(rgx, Regexp::IGNORECASE)
      end

      def output_ext(ext)                                               # md->html, markdown->html, etc
        ".html"
      end

      def convert(content)
        setup                                                           # convert 前，先 setup（确保）
        @parser.convert(content)                                        # 再用 parser convert，输出字符串
      end
    end
  end
end
