#tzx：
#   -   原样输出
#   -   文件名到内容都是 identity

module Jekyll
  module Converters
    class Identity < Converter
      safe true                         # 来自 Plugin 的函数，设为 true

      priority :lowest                  # 话说 symbol 不会冲突嘛？

      def matches(ext)                  # 什么文件都可以……
        true
      end

      def output_ext(ext)               # identity……
        ext
      end

      def convert(content)              # identity……
        content
      end
    end
  end
end
