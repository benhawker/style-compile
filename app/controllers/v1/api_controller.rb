module V1
  class ApiController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods

    before_filter :ensure_user

    private

    def user
      @user
    end

    def ensure_user
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_or_request_with_http_token do |token, options|
        @user = User.find_by(access_token: token)
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: 'Bad Credentials', status: 401
    end

  end
end