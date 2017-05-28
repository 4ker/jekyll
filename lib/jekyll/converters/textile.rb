#tzx：
#   -   用了 RedCloth 来转化
#   -   似乎只要 gem install 了，ruby 程序里就能直接 require……
#   -   从 C++ 转过来的人好羡慕……

module Jekyll
  module Converters
    class Textile < Converter
      safe true

      #tzx：依旧不明所以……
      pygments_prefix '<notextile>'
      pygments_suffix '</notextile>'

      def setup
        return if @setup
        require 'redcloth'
        @setup = true
      rescue LoadError                                                                  # good！没有用 begin ... rescue ... end 直接内嵌。
        STDERR.puts 'You are missing a library required for Textile. Please run:'       # 哎……只要 gem install 了……就能 require 了……好方便啊！
        STDERR.puts '  $ [sudo] gem install RedCloth'
        raise FatalException.new("Missing dependency: RedCloth")                        # 直接中断
      end

      def matches(ext)
        rgx = '(' + @config['textile_ext'].gsub(',','|') +')'
        ext =~ Regexp.new(rgx, Regexp::IGNORECASE)
      end

      def output_ext(ext)
        ".html"
      end

      def convert(content)
        setup

        # Shortcut if config doesn't contain RedCloth section
        return RedCloth.new(content).to_html if @config['redcloth'].nil?                # 唔需要配置

        # List of attributes defined on RedCloth
        # (from http://redcloth.rubyforge.org/classes/RedCloth/TextileDoc.html)
        attrs = ['filter_classes', 'filter_html', 'filter_ids', 'filter_styles',
                'hard_breaks', 'lite_mode', 'no_span_caps', 'sanitize_html']

        r = RedCloth.new(content)

        # Set attributes in r if they are NOT nil in the config
        attrs.each do |attr|
          #tzx：
          #   -   str.to_sym 似乎很不错
          #   -   如果 @config['redcloth'][attr] 非空，就覆盖默认的值（哪怕是错误的……）
          r.instance_variable_set("@#{attr}".to_sym, @config['redcloth'][attr]) unless @config['redcloth'][attr].nil?
        end

        r.to_html
      end
    end
  end
end
