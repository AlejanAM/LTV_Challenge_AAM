class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validate :validate_full_url


  #With the URL id in table it converts the
  #decimal id to base 62 number and with
  #each each digit it finds the base 62
  #and if the given id equals null returns
  #the code as null
  def short_code
    key = self.id
    str = ""
    if key == nil
      str = nil
    else
      while key > 0
        str += CHARACTERS[key % 62]
        key = (key/62)
      end
      str.reverse
    end
  end

  #Given the short code previously
  #generated, this method reverts
  #to base 10 to use the id to redirect
  #to the original URL
  def self.find_by_short_code(str)
    exp = id = 0
    str.to_s.reverse.each_char do |i|
      id += ((62**exp)*CHARACTERS.index(i))
      exp+=1
    end
    ShortUrl.find_by_id(id)
  end


  #Returns the actual shortcode
  #for the URL when asked
  def public_attributes
    self.short_code
  end

  #Method executed by the job, getting
  #the html of the given url and changing
  #the title updating its column
  def update_title!
    uri = URI.parse(full_url)
    html = Net::HTTP.get_response(uri)
    regex = /<title>([^<]*)<\/title>/
    
    if html.is_a?(Net::HTTPSuccess)
      title = html.body.match(regex)[1]
      self.update_columns(title:title)
    else
      errors.add(:errors,"Error loading html")
    end
  end

  private


  #Validates the existence of a body on the URL
  #and only accepts the sites with security (HTTPS)
  def validate_full_url
    begin
      uri = URI.parse(full_url)
    rescue URI::InvalidURIError
      errors.add(:errors,"is not a valid url")
    end
    if full_url == "" || full_url == nil
      errors.add(:full_url,"can't be blank")
    elsif !uri.kind_of?(URI::HTTPS)
      errors.add(:full_url,"is not a valid url")
      errors.add(:errors,"Full url is not a valid url")
    end
    

  end
 

end
