class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  #Returns the Url's based on the amount of clicks
  #with a limit of 100
  def index
    result = ShortUrl.limit(100).order('click_count desc')
    render json:{
      urls: result.map{
        |code|code.short_code
      },
      status: 200
    }


  end

  #Takes the URLS in string format, checks
  #if there are any errors and executes the
  #post on the database
  def create
    @crURL = ShortUrl.new(full_url:params[:full_url])
    if crURL.save
      render json: {short_code: @crURL.short_code}, status: 200
    else
      render json: @crURL.errors
    end
  end

  def show

  end

end
