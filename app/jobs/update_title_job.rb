class UpdateTitleJob < ApplicationJob
  queue_as :default

  #Connects to the short_code model searching
  #by id an the performs the method updating
  #the title using the url
  def perform(short_url_id)
    short_url = ShortUrl.find(short_url_id)
    short_url.update_title!
  end
end
