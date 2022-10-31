class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validate :validate_full_url


  #With the URL id in table it converts the
  #decimal id to base 62 number and with
  #each each digit it finds the base 62
  def short_code
    key = self.id
    str = ""
    while key > 0
      str += CHARACTERS[key % 62]
      key = (key/62).floor
    end
    str.reverse
  end

  #Returns the actual shortcode
  #for the URL when asked
  def public_attributes
    self.short_code
  end

  def update_title!
  end

  private


  #Validates the existence of a host on the URL
  #and only the sites with security (HTTPS)
  def validate_full_url
    begin
      uri = URI.parse(full_url)
    rescue URI::InvalidURIError
    end
    if !uri.host && !uri.kind_of?(URI::HTTPS)
      errors.add(:errors,"Full url is not a valid url")
    end
  end
 

end
