#tzx：
#   -   文件名
#   -   Draft 继承了 Post

module Jekyll

  class Draft < Post

    # Valid post name regex (no date)
    MATCHER = /^(.*)(\.[^.]+)$/

    # Draft name validator. Draft filenames must be like:
    # my-awesome-post.textile
    #
    # Returns true if valid, false if not.
    def self.valid?(name)
      name =~ MATCHER
    end

    # Get the full path to the directory containing the draft files
    def containing_dir(source, dir)
      #tzx：join(string, ...) → string click to toggle source
      #   Returns a new string formed by joining the strings using File::SEPARATOR.
      File.join(source, dir, '_drafts')
    end

    # Extract information from the post filename.
    #
    # name - The String filename of the post file.
    #
    # Returns nothing.
    def process(name)
      #tzx：这里 name.match 返回了一个 array，然后被 splat，然后保存起来
      #   m 是全部，slug 是缩略名（去掉 ext），ext 是后缀，带“.”。
      #    Post Slug 文章缩略名
      m, slug, ext = *name.match(MATCHER)

      self.date = File.mtime(File.join(@base, name))
      self.slug = slug
      self.ext = ext
    end

  end

end
