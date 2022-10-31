class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validate :validate_full_url

  def short_code
  end

  def update_title!
  end

  private


  #Validates if there is a host on the URL
  #and only the sites with security (HTTPS)
  def validate_full_url
    begin
      uri = URI.parse(full_url)
    rescue URI::InvalidURIError
    end
    if !uri.host && uri.kind_of?(URI::HTTPS)
      errors.add(:errors,"Invalid URL")
    end
  end
 

end
