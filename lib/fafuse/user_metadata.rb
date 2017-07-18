require "fafuse/helpers"
require "json"

module FAFuse
  class UserMetadata
  
    attr_accessor :path, :slug

    def self.match?(path)
      path.match(/^\/([^\.][^\/]+)\/metadata.json$/)
    end

    def initialize(path)
      @path = path
      @slug = UserMetadata.match?(path)[1]
      @resource = RestClient::Resource.new("http://www.furaffinity.net/user/")
    end

    def valid?
      !!slug && slug[0] != "."
    end
  
    def stat
      return RFuse::Stat.file(0444, {
                                :uid => 0,
                                :gid => 0,
                                :atime => Time.now,
                                :mtime => Time.now,
                                :size => content.size
                              })
    end

    def exists?
      Helpers::fa_is_valid?(document)
    end
  
    def content
      JSON.generate({ slug: slug })
    end

    protected
    
    def document
      @document ||= Nokogiri::HTML(@resource[slug].get.body)
    end
  end
end
