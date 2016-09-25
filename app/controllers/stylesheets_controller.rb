class StylesheetsController < ApplicationController
  before_action :set_stylesheet, only: [:show, :update, :destroy]

  # GET /stylesheets
  def index
    @stylesheets = Stylesheet.all

    render json: @stylesheets
  end

  # GET /stylesheets/1
  def show
    render json: @stylesheet
  end

  # POST /stylesheets
  def create
    @stylesheet = Stylesheet.new(stylesheet_params)

    if @stylesheet.save
      render json: @stylesheet, status: :created, location: @stylesheet
    else
      render json: @stylesheet.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stylesheets/1
  def update
    if @stylesheet.update(stylesheet_params)
      render json: @stylesheet
    else
      render json: @stylesheet.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stylesheets/1
  def destroy
    @stylesheet.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stylesheet
      @stylesheet = Stylesheet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def stylesheet_params
      params.require(:stylesheet).permit(:url)
    end
end
