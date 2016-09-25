module V1
  class StylesheetsController < ApiController

    # GET /v1/stylesheets
    def index
      render json: Stylesheet.all
    end

  end
end