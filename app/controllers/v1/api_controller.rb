module V1
  class ApiController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods

    before_action :ensure_user

    rescue_from ActiveRecord::RecordNotFound do |exception|
      render nothing: true, status: :not_found
    end

    rescue_from ActionController::RoutingError do |exception|
      render nothing: true, status: 404
    end

    private

    def ensure_user
      false unless user
    end

    def user
      @user ||= User.where(access_token: current_access_token).first
    end

    def current_access_token
      authenticate_or_request_with_http_token do |token, options|
        @user = User.find_by(access_token: token)
      end
    end
  end
end