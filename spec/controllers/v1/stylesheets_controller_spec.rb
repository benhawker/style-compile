require 'rails_helper'

RSpec.describe V1::StylesheetsController, :type => :controller do

  let(:valid_attributes) do
    {
      "brand-success"     => "#5cb85c",
      "brand-primary"     => "#5cb85c",
      "brand-info"        => "#5cb85c",
      "brand-danger"      => "#5cb85c",
      "brand-warning"     => "#5cb85c"
    }
  end

  let(:invalid_attributes) do
    {
      "bad_request"     => "bad params",
    }
  end

end
