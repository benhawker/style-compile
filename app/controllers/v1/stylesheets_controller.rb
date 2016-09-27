module V1
  class StylesheetsController < ApiController

    # # GET /stylesheets
    def index
      @stylesheets = Stylesheet.from_user(user).order(updated_at: :desc)

      if @stylesheets
        status = :ok
      else
        status = :not_found
      end

      render json: @stylesheets, status: status
    end

    # # GET /stylesheets/1
    def show
      @stylesheet = Stylesheet.from_user(user).where(id: params[:id]).first

      if @stylesheet
        status = :ok
      else
        status = :not_found
      end

      render json: @stylesheet, status: status
    end

    # Format expected (JSON content type):
    #
    # {
    #   "brand-success": "#5cb85c",
    #   "brand-primary": "#5cb85c",
    #   "brand-info" : "#5cb85c",
    #   "brand-danger": "#5cb85c",
    #   "brand-warning": "#5cb85c"
    # }

    # # Optional parameters
    # {
    #   "font-family-base": "@font-family-sans-serif"
    #   "font-size-base"  : "14px"
    #   "font-size-large" : "ceil((@font-size-base * 1.25))"
    #   "font-size-small" : "ceil((@font-size-base * 0.85))"
    # }

    # # POST /stylesheets
    def create
      @stylesheet = StylesheetPublisher.new(user, params["brand-success"]).publish!

      # puts "inspectinf"
      # puts params.inspect

      # puts params[:controller]

      # puts params["brand-success"]

      if @stylesheet
        status = :ok
      else
        status = :unprocessable_entity
      end

      render json: @stylesheet, status: status
    end

    private

    def stylesheet_params
      params.require(:stylesheet).permit(:"brand-success",
        :"brand-primary", :"brand-info", :"brand-danger",
        :"brand-warning", :"font-family-base", :"font-size-base",
        :"font-size-large", :"font-size-small"
      )
    end
  end
end