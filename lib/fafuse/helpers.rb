module FAFuse
  class Helpers
    def self.fa_is_unauthorized?(document)
      document.text.include?("content available to registered users only")
    end

    def self.fa_is_error?(document)
      document.css("title").text =~ /system error/i
    end

    def self.fa_is_invalid?(document)
      fa_is_unauthorized?(document) || fa_is_error?(document)
    end

    def self.fa_is_valid?(document)
      !fa_is_invalid?(document)
    end
  end
end
