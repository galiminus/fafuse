require "fafuse/helpers"

module FAFuse
  class PictureFile
  
    attr_accessor :path, :id

    def self.match?(path)
      path.match(/^\/[^\.][^\/]+\/gallery\/([^\.][^\/]+)\/file\.[^\/]+$/)
    end

    def initialize(path)
      @id = PictureFile.match?(path)[1]
      @path = path
      @resource = RestClient::Resource.new("http://www.furaffinity.net/full/")
    end

    def valid?
      !!id
    end
  
    def stat
      RFuse::Stat.file(0444, {
                         :uid => 0,
                         :gid => 0,
                         :atime => Time.now,
                         :mtime => Time.now,
                         :size => content.size
                       })
    end

    def exists?
      Helpers::fa_is_valid?(document)
    rescue RestClient::NotFound
      false
    end
  
    def content
      RestClient.get(document.css("#submissionImg").first["src"].gsub(/^\/\//, "http://")).body
    end

    protected
    
    def document
      @document ||= Nokogiri::HTML(@resource[id].get.body)
    end
  end
end
