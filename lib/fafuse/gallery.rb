require "fafuse/helpers"

module FAFuse
  class Gallery
  
    attr_accessor :path, :slug

    def self.match?(path)
      path.match(/^\/([^\.][^\/]+)\/gallery$/)
    end

    def initialize(path)
      @path = path
      @slug = Gallery.match?(path)[1]
      @resource = RestClient::Resource.new("http://www.furaffinity.net/gallery/")
    end

    def valid?
      !!slug && slug[0] != "."
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
    end
  
    def content
      [].tap do |content|
        loop.with_index do |_, page|
          @gallery = Nokogiri::HTML(@resource[slug][page + 1].get.body)
          break if @gallery.text.include?("There are no submissions to list")
          
          pictures = @gallery.css("#gallery-gallery figcaption a").map do |link|
            if link['href'].match(/^\/view\/.+\/$/)
              link['href'].match(/^\/view\/(.+)\/$/)[1]
            end
          end.compact
          
          content.concat pictures
        end
      end
    end

    protected
    
    def document
      @document ||= Nokogiri::HTML(@resource[slug].get.body)
    end
  end
end
