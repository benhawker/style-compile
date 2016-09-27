class ApplicationController < ActionController::API
  def default_url_options
    if Rails.env.production?
      { host: "www.stylecompile.com" }
    else
      {}
    end
  end
end
