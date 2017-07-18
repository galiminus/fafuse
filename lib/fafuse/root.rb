module FAFuse
  class Root
    attr_accessor :path

    def self.match?(path)
      path.match(/^\/$/)
    end

    def initialize(path)
      @path = path
    end

    def valid?
      true
    end

    def stat
      RFuse::Stat.directory(0111, {
                              :uid => 0,
                              :gid => 0,
                              :atime => Time.now,
                              :mtime => Time.now,
                              :size => 0
                            })
    end

    def content
      raise Errno::EACCES.new(path)
    end
  end
end
