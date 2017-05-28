#tzx
#   -   去掉没有 included，没有 special，没有 backup，excluded……symlink 啥的……entries。

class EntryFilter
  attr_reader :site
  def initialize(site)
    @site = site
  end

  def filter(entries)
    entries.reject do |e|
      unless included?(e)
        special?(e) || backup?(e) || excluded?(e) || symlink?(e)
      end
    end
  end

  def included?(entry)
    site.include.glob_include?(entry)
  end

  def special?(entry)
    ['.', '_', '#'].include?(entry[0..0])
  end

  #tzx：最后一个字符是 ~？那就是 backup。
  def backup?(entry)
    entry[-1..-1] == '~'
  end

  def excluded?(entry)
    site.exclude.glob_include?(entry)
  end

  def symlink?(entry)
    File.symlink?(entry) && site.safe
  end

end
