require "fafuse/helpers"

module FAFuse
  class User
  
    attr_accessor :path, :slug

    def self.match?(path)
      path.match(/^\/([^\.][^\/]+)$/)
    end
    
    def initialize(path)
      @path = path
      @slug = User.match?(path)[1]
      @resource = RestClient::Resource.new("http://www.furaffinity.net/user/")
    end

    def valid?
      !!slug && slug[0] != "." && exists?
    end
    
    def exists?
      Helpers::fa_is_valid?(document)
    end

    def stat
      return RFuse::Stat.directory(0755, {
                                     :uid => 0,
                                     :gid => 0,
                                     :atime => Time.now,
                                     :mtime => Time.now,
                                     :size => 0
                                   })
    end

    def content
      [ "gallery" ]
    end

    protected

    def document
      @document ||= Nokogiri::HTML(@resource[slug].get.body)
    end
  end
end
