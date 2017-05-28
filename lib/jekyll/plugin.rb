#tzx：
#   -   plugin 其实有一个 priority 来排序
#   -   有 subclasses 来管理下面的 subclasses
#   -   其他也没啥了

module Jekyll
  class Plugin
    PRIORITIES = { :lowest => -100,
                   :low => -10,
                   :normal => 0,
                   :high => 10,
                   :highest => 100 }

    # Install a hook so that subclasses are recorded. This method is only
    # ever called by Ruby itself.
    #
    # base - The Class subclass.
    #
    # Returns nothing.
    def self.inherited(base)
      subclasses << base                # 这是一个列表……
      subclasses.sort!
    end

    # The list of Classes that have been subclassed.
    #
    # Returns an Array of Class objects.
    def self.subclasses
      @subclasses ||= []
    end

    # Get or set the priority of this plugin. When called without an
    # argument it returns the priority. When an argument is given, it will
    # set the priority.
    #
    # priority - The Symbol priority (default: nil). Valid options are:
    #            :lowest, :low, :normal, :high, :highest
    #
    # Returns the Symbol priority.
    def self.priority(priority = nil)
      @priority ||= nil
      if priority && PRIORITIES.has_key?(priority)
        @priority = priority
      end
      @priority || :normal              # symbol 到处可以用……
    end

    # Get or set the safety of this plugin. When called without an argument
    # it returns the safety. When an argument is given, it will set the
    # safety.
    #
    # safe - The Boolean safety (default: nil).
    #
    # Returns the safety Boolean.
    def self.safe(safe = nil)
      if safe
        @safe = safe                    # 直接用 true 不就好……
      end
      @safe || false
    end

    # Spaceship is priority [higher -> lower]
    #
    # other - The class to be compared.
    #
    # Returns -1, 0, 1.
    def self.<=>(other)                 # 比较的时候用 PRIORITIES 来比较，PRIORITIES 是一个 Hash。
      PRIORITIES[other.priority] <=> PRIORITIES[self.priority]
    end

    # Initialize a new plugin. This should be overridden by the subclass.
    #
    # config - The Hash of configuration options.
    #
    # Returns a new instance.
    def initialize(config = {})         # 啊啊……soga。
      # no-op for default
    end
  end
end
