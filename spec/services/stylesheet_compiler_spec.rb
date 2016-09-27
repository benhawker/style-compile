require 'rails_helper'

RSpec.describe StylesheetCompiler do

  let(:params) do
    { "access_token" => "1", "brand-success" => "123" }
  end

  subject { described_class.new(params) }

  describe "#compile!" do
    it "returns a compiled stylesheet" do
      expect(subject.compile!).to eq "xxx"
    end
  end
end
