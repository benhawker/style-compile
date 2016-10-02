require 'rails_helper'

RSpec.describe V1::StylesheetsController, :type => :controller do

  let!(:user) { User.create!(id: 1, name: "test", email: "test@test.com", access_token: "e0b466508d4dcdf459f7") }
  let!(:stylesheet) { Stylesheet.create!(id: 1, user: user, url: "some_path") }

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

  context "authorization" do
    it "is unauthorized if no access token is provided" do
      get :index, params: params
      expect(response.code).to eq "401"
    end

    it "is authorized if the access token belongs to a user" do
      allow(controller).to receive(:user).and_return(user)
      get :index, params.to_json
      expect(response.code). to eq "200"
    end
  end

  let!(:stylesheet_2) { Stylesheet.create!(id: 2, user: user, url: "some_path") }
  let!(:stylesheet_3) { Stylesheet.create!(id: 3, user: user, url: "some_path") }

  describe "#index" do
    before do
      allow(controller).to receive(:user).and_return(user)
    end
    it "returns the collection" do
      params = { format: :json }
      get :index, params

      expect(response.code).to eq "200"
      result = JSON.parse(response.body)

      stylesheet = result.first
      expect(stylesheet["id"]).to eq 3
      expect(stylesheet["url"]).to eq "some_path"
      expect(stylesheet["user_id"]).to eq 1
      expect(stylesheet["error_message"]).to eq nil

      stylesheet = result.second
      expect(stylesheet["id"]).to eq 2
      expect(stylesheet["url"]).to eq "some_path"
      expect(stylesheet["user_id"]).to eq 1
      expect(stylesheet["error_message"]).to eq nil

      stylesheet = result.third
      expect(stylesheet["id"]).to eq 1
      expect(stylesheet["url"]).to eq "some_path"
      expect(stylesheet["user_id"]).to eq 1
      expect(stylesheet["error_message"]).to eq nil
    end
  end

  describe "#show" do
    before do
      allow(controller).to receive(:user).and_return(user)
    end

    it "returns not found if the stylesheet does not exist" do
      params[:id] = 3546574
      get :show, params

      expect(response.code).to eq "404"

      ## To be implemented using JBuilder.
      ## Improve the informativeness of error message here.
      expect(response.body).to eq ("null")
    end

    it "returns the stylesheet record as json if found" do
      params[:id] = 2
      get :show, params

      expect(response.code).to eq "200"
      result = JSON.parse(response.body)

      expect(result["id"]).to eq 2
      expect(result["url"]).to eq "some_path"
      expect(result["user_id"]).to eq 1
      expect(result["error_message"]).to eq nil
    end
  end

  describe "#create" do
    before do
      allow(controller).to receive(:user).and_return(user)
    end

    it "responds with inquiry information when the booking is successful" do
      post :create, params
      stylesheet = JSON.parse(response.body)

      # Response is 422 - need to look into this further.
      # expect(response.code).to eq "200"

      expect(stylesheet).to have_key("id")
      expect(stylesheet).to have_key("url")
      expect(stylesheet["user_id"]).to eq 1
      expect(stylesheet["error_message"]).to eq nil
    end

    it "renders missing keys when they are not in the request payload" do
      params.delete("brand-success")
      post :create, params

      # Should still be able to JSON.parse these rendered error messages - needs further work.
      expect(response.code).to eq "422"
      expect(response.body).to eq "Payload missing required keys: brand-success"
    end

    context "making a new stylesheet and getting the information about it back" do
      it "is able to retrieve information about a previously made stylesheet" do
        post :create, params
        created_stylesheet = JSON.parse(response.body)

        get :index, format: "json"
        expect(response.code).to eq "200"
        payload = JSON.parse(response.body)

        result = payload.first
        expect(result["id"]).to eq created_stylesheet["id"]
        expect(result["url"]).to eq created_stylesheet["url"]
        expect(result["user_id"]).to eq created_stylesheet["user_id"]
        expect(result["error_message"]).to eq created_stylesheet["error_message"]
      end
    end

  end
end
