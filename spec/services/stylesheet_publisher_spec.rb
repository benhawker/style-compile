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

    let(:folder_path) { Rails.root.join("spec/assets/") }
    let(:file_path) { "#{folder_path}test_a893.css" }

    before do
      allow(subject).to receive(:filename).and_return("test_a893.css")
      allow(subject).to receive(:path) { folder_path }
      subject.publish!
    end

    context "persisting the compiled stylesheet" do
      it "persists a .css file to the public/stylesheets dir" do
        expect(Dir.entries(folder_path)).to include "test_a893.css"
      end

      it "persists the correct interpolated & compiled data in the file" do
        file_content = File.read(file_path)
        compiled_content = ".box {\n  width: 65px;\n  color: saturate(\"#5cb85c\", 5%);\n  border-color: \"#5cb85c\";\n}\n.box div {\n  -webkit-box-shadow: 0 0 5px rgba(0, 0, 0, 0.3);\n  box-shadow: 0 0 5px rgba(0, 0, 0, 0.3);\n}\n"
        expect(file_content).to eq compiled_content
      end

      after do
        File.delete(file_path)
      end
    end

    it "the url is persisted to the stylesheet record correctly." do
      stylesheet_record = Stylesheet.last
      expect(stylesheet_record.url).to eq file_path
    end
  end
end
