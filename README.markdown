    lib
    ├── jekyll
    │   ├── cleaner.rb
    │   ├── command.rb
    │   ├── commands
    │   │   ├── build.rb
    │   │   ├── doctor.rb
    │   │   ├── new.rb
    │   │   └── serve.rb
    │   ├── configuration.rb                        #tzx：配置
    │   ├── converter.rb
    │   ├── converters
    │   │   ├── identity.rb
    │   │   ├── markdown
    │   │   │   ├── kramdown_parser.rb
    │   │   │   ├── maruku_parser.rb
    │   │   │   ├── rdiscount_parser.rb
    │   │   │   └── redcarpet_parser.rb
    │   │   ├── markdown.rb
    │   │   └── textile.rb
    │   ├── convertible.rb
    │   ├── core_ext.rb                             #tzx：Hash#deep_merge，
                                                    #   Hash#pluralized_array，Hash#symbolize_keys!，Hash#symbolize_keys，
                                                    #   Enumerable#glob_include?，Date#xmlschema，File#read_with_options，
    │   ├── deprecator.rb
    │   ├── draft.rb                                #tzx：继承自 Post
    │   ├── entry_filter.rb                         #tzx：filter 掉一些文件
    │   ├── errors.rb                               #tzx：啥都没有，只有一个 FatalException
    │   ├── excerpt.rb
    │   ├── filters.rb
    │   ├── generator.rb
    │   ├── generators
    │   │   └── pagination.rb
    │   ├── layout.rb
    │   ├── mime.types
    │   ├── page.rb
    │   ├── plugin.rb
    │   ├── post.rb
    │   ├── related_posts.rb
    │   ├── site.rb
    │   ├── static_file.rb
    │   ├── stevenson.rb
    │   ├── tags
    │   │   ├── gist.rb
    │   │   ├── highlight.rb
    │   │   ├── include.rb
    │   │   └── post_url.rb
    │   └── url.rb                          #tzx：这个比较简单，只是一个 url 模板的 expand
    ├── jekyll.rb
    └── site_template
        ├── _config.yml
        ├── css
        │   ├── main.css
        │   └── syntax.css
        ├── index.html
        ├── _layouts
        │   ├── default.html
        │   └── post.html
        └── _posts
            └── 0000-00-00-welcome-to-jekyll.markdown.erb

---

# Jekyll

[![Gem Version](https://badge.fury.io/rb/jekyll.png)](http://badge.fury.io/rb/jekyll)

[![Build Status](https://secure.travis-ci.org/jekyll/jekyll.png?branch=master)](https://travis-ci.org/jekyll/jekyll)
[![Code Climate](https://codeclimate.com/github/jekyll/jekyll.png)](https://codeclimate.com/github/jekyll/jekyll)
[![Dependency Status](https://gemnasium.com/jekyll/jekyll.png)](https://gemnasium.com/jekyll/jekyll)
[![Coverage Status](https://coveralls.io/repos/jekyll/jekyll/badge.png)](https://coveralls.io/r/jekyll/jekyll)

By Tom Preston-Werner, Nick Quaranto, and many awesome contributors!

Jekyll is a simple, blog aware, static site generator. It takes a template
directory (representing the raw form of a website), runs it through Textile or
Markdown and Liquid converters, and spits out a complete, static website
suitable for serving with Apache or your favorite web server. This is also the
engine behind [GitHub Pages](http://pages.github.com), which you can use to
host your project's page or blog right here from GitHub.
把一个文件夹的模板和文本，转化为一个静态博客。

## Getting Started

* [Install](http://jekyllrb.com/docs/installation/) the gem
* Read up about its [Usage](http://jekyllrb.com/docs/usage/) and [Configuration](http://jekyllrb.com/docs/configuration/)
* Take a gander at some existing [Sites](http://wiki.github.com/jekyll/jekyll/sites)
* Fork and [Contribute](http://jekyllrb.com/docs/contributing/) your own modifications
* Have questions? Check out `#jekyll` on irc.freenode.net.

## Diving In

* [Migrate](http://jekyllrb.com/docs/migrations/) from your previous system
* Learn how the [YAML Front Matter](http://jekyllrb.com/docs/frontmatter/) works
* Put information on your site with [Variables](http://jekyllrb.com/docs/variables/)
* Customize the [Permalinks](http://jekyllrb.com/docs/permalinks/) your posts are generated with
* Use the built-in [Liquid Extensions](http://jekyllrb.com/docs/templates/) to make your life easier
* Use custom [Plugins](http://jekyllrb.com/docs/plugins/) to generate content specific to your site

## Runtime Dependencies

* Commander: Command-line interface constructor (Ruby)
* Colorator: Colorizes command line output (Ruby)
* Classifier: Generating related posts (Ruby)
* Directory Watcher: Auto-regeneration of sites (Ruby)
* Liquid: Templating system (Ruby)
* Maruku: Default markdown engine (Ruby)
* Pygments.rb: Syntax highlighting (Ruby/Python)
* RedCarpet: Markdown engine (Ruby)
* Safe YAML: YAML Parser built for security (Ruby)

## Developer Dependencies

* Kramdown: Markdown-superset converter (Ruby)
* Launchy: Cross-platform file launcher (Ruby)
* RDiscount: Discount Markdown Processor (Ruby)
* RedCloth: Textile support (Ruby)
* RedGreen: Nicer test output (Ruby)
* RR: Mocking (Ruby)
* Shoulda: Test framework (Ruby)
* SimpleCov: Coverage framework (Ruby)

## License

See [LICENSE](https://github.com/jekyll/jekyll/blob/master/LICENSE).
