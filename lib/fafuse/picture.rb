require "fafuse/helpers"

module FAFuse
  class Picture
  
    attr_accessor :path, :id

    def self.match?(path)
      path.match(/^\/[^\.][^\/]+\/gallery\/([^\.][^\/]+)$/)
    end

    def initialize(path)
      @id = Picture.match?(path)[1]
      @path = path
      @resource = RestClient::Resource.new("http://www.furaffinity.net/view/")
    end

    def valid?
      !!id
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

    def exists?
      Helpers::fa_is_valid?(document)
    rescue RestClient::NotFound
      false
    end
  
    def content
      if exists?
        []
      else
        raise Errno::ENOENT.new(path)
      end
    end

    protected

    def document
      @document ||= Nokogiri::HTML(@resource[id].get.body)
    end
  end
end
