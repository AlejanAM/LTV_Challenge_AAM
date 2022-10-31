class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
  end

  #Takes the URLS in string format, checks
  #if there are any errors and executes the
  #post on the database
  def create
    crURL = ShortUrl.new(full_url:params[:full_url])
    if crURL.save
      render json: crURL, status: 200
    else
      render json: {error:crURL.errors}
    end
  end

  def show
  end

end
