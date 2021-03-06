require 'rails_helper'

RSpec.describe StylesheetCompiler do

  let(:params) do
    {
      "brand-success" => "#5cb85c",
      "brand-primary" => "#123",
      "brand-info"    => "#456",
      "brand-danger"  => "#789",
      "brand-warning" => "#abc"
    }
  end

  let(:user) { User.create(name: "test", email: "test@test.com", access_token: 1) }
  subject { described_class.new(user, params) }

  describe "#compile!" do
    it "returns a compiled stylesheet" do
      compiled_output = ".box {\n  width: 65px;\n  color: saturate(\"#5cb85c\", 5%);\n  border-color: \"#5cb85c\";\n}\n.box div {\n  -webkit-box-shadow: 0 0 5px rgba(0, 0, 0, 0.3);\n  box-shadow: 0 0 5px rgba(0, 0, 0, 0.3);\n}\n"
      expect(subject.compile!).to eq compiled_output
    end

    it "raises an error if the required keys are not passed" do
      expect { described_class.new(user, "brand-nothing" => "123").compile! }.to raise_error(InvalidPayloadError)
    end
  end
end
