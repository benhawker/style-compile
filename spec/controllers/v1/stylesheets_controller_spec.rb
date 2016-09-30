require 'rails_helper'

RSpec.describe V1::StylesheetsController, :type => :controller do

  let!(:user) { User.create!(name: "test", email: "test@test.com", access_token: "e0b466508d4dcdf459f7") }
  let!(:stylesheet) { Stylesheet.create!(user: user, url: "some_path") }

  let(:params) do
    {
      "brand-success"     => "#5cb85c",
      "brand-primary"     => "#5cb85c",
      "brand-info"        => "#5cb85c",
      "brand-danger"      => "#5cb85c",
      "brand-warning"     => "#5cb85c"
    }
  end

  let(:invalid_params) do
    {
      "wrong_key"     => "bad params",
    }
  end

  it "is unauthorized if no access token is provided" do
    get :index, params: params
    expect(response.code).to eq "401"
  end


  it "is authorized if the access token belongs to a user" do
    # To be changed - don't stub this. Pass correct headers and test api_controller implementation.
    allow(controller).to receive(:user).and_return(user)
    allow(controller).to receive(:ensure_user).and_return(true)

    #headers = {'Accept' => 'application/json', 'Content-Type' => 'application/json', 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials(user.access_token) }
    get :index, params.to_json
    expect(response.code). to eq "200"
  end
end
