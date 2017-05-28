#tzx：
#   -   generate_url 可以从 @placeholder 和 模板里面拼接一个 url 字符串
#   -   sanitize_url 很奇特，处理了 trailing /，还处理了首字符 /，如果没有的话……

# Public: Methods that generate a URL for a resource such as a Post or a Page.
#
# Examples
#
#   URL.new({
#     :template => /:categories/:title.html",
#     :placeholders => {:categories => "ruby", :title => "something"}
#   }).to_s
#
module Jekyll
  class URL

    # options - One of :permalink or :template must be supplied.
    #           :template     - The String used as template for URL generation,
    #                           for example "/:path/:basename:output_ext", where
    #                           a placeholder is prefixed with a colon.
    #           :placeholders - A hash containing the placeholders which will be
    #                           replaced when used inside the template. E.g.
    #                           { "year" => Time.now.strftime("%Y") } would replace
    #                           the placeholder ":year" with the current year.
    #           :permalink    - If supplied, no URL will be generated from the
    #                           template. Instead, the given permalink will be
    #                           used as URL.
    def initialize(options)
      @template = options[:template]
      @placeholders = options[:placeholders] || {}
      @permalink = options[:permalink]

      #tzx:
      #     -   这特么都行？
      if (@template || @permalink).nil?
        raise ArgumentError, "One of :template or :permalink must be supplied."
      end
    end

    # The generated relative URL of the resource
    #
    # Returns the String URL
    def to_s
      sanitize_url(@permalink || generate_url)      #tzx：sanitize，无毒，如果有 permalink 就用 permalink，否则，用 generate_url
    end

    # Internal: Generate the URL by replacing all placeholders with their
    # respective values
    #
    # Returns the _unsanitizied_ String URL
    #tzx：
    #   -   这个很巧妙
    #   -   是从 placeholder 一个个来替换原来的 template，结果就是一个 apply 了模板的字符串
    def generate_url
      @placeholders.inject(@template) do |result, token|
        result.gsub(/:#{token.first}/, token.last)
      end
    end

    # Returns a sanitized String URL
    def sanitize_url(in_url)

      # Remove all double slashes
      url = in_url.gsub(/\/\//, "/")

      # Remove every URL segment that consists solely of dots
      url = url.split('/').reject{ |part| part =~ /^\.+$/ }.join('/')               #tzx

      # Append a trailing slash to the URL if the unsanitized URL had one
      url += "/" if in_url =~ /\/$/                                                 #tzx

      # Always add a leading slash
      url.gsub!(/\A([^\/])/, '/\1')                                                 #tzx：其实没必要用 regexp 的，用 if modifier 就好

      url
    end
  end
end
