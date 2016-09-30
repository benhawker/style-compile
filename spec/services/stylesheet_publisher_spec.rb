require 'rails_helper'

RSpec.describe StylesheetPublisher do

  let(:user) { User.create(name: "test", email: "test@test.com", access_token: 1) }

  let(:params) do
    {
      "brand-success" => "#5cb85c",
      "brand-primary" => "#5cb85c",
      "brand-info"    => "#5cb85c",
      "brand-danger"  => "#5cb85c",
      "brand-warning" => "#5cb85c"
    }
  end

  subject { described_class.new(user, params) }

  describe "#publish!" do
    it "creates a new Stylesheet record in the db" do
      expect { subject.publish! }.to change { Stylesheet.count }.by(1)
    end

    before do
      allow(subject).to receive(:filename).and_return("test_a893.css")
    end

    let(:folder_path) { Rails.root.join("spec/assets/") }
    let(:file_path) { "#{folder_path}test_a893.css" }

    it "persists a .css file to the public/stylesheets dir" do
      allow(subject).to receive(:path) { folder_path }
      subject.publish!
      expect(Dir.entries(folder_path)).to include "test_a893.css"
      File.delete(file_path)
    end

    it "the url is persisted to the stylesheet record correctly." do
      subject.publish!
      stylesheet_record = Stylesheet.last
      expect(stylesheet_record.url).to eq "#{Rails.root}/public/test_a893.css"
    end
  end
end
