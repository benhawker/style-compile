require 'rails_helper'

RSpec.describe StylesheetCompiler do

  let(:params) do
    {
      "brand-success" => "#5cb85c",
      "brand-primary" => "#5cb85c",
      "brand-info"    => "#5cb85c",
      "brand-danger"  => "#5cb85c",
      "brand-warning" => "#5cb85c"
    }
  end

  let(:user) { User.create(name: "test", email: "test@test.com", access_token: 1) }
  subject { described_class.new(user, params) }

  describe "#compile!" do
    it "returns a compiled stylesheet" do
      fake_css = "\n@brand-success:   || DEFAULT_COLOR\n@brand-primary\":  || DEFAULT_COLOR\n@brand-info\" :       || DEFAULT_COLOR\n@brand-danger\":    || DEFAULT_COLOR\n@brand-warning\":  || DEFAULT_COLOR\n"

      puts subject.compile!
      expect(subject.compile!).to eq fake_css
    end

    it "raises an error if the required keys are not passed" do
      expect { described_class.new(user, "brand-nothing" => "123").compile! }.to raise_error(InvalidPayloadError)
    end
  end
end
