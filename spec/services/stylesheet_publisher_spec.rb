require 'rails_helper'

RSpec.describe StylesheetPublisher do

  let(:user) { User.create(name: "test", email: "test@test.com", access_token: 1) }
  let(:params) do
    { "access_token" => "1", "brand-success" => "123" }
  end

  subject { described_class.new(user, params) }

  describe "#publish!" do
    it "creates a new Stylesheet record in the db" do
      expect { subject.publish! }.to change { Stylesheet.count }.by(1)
    end

    before do
      allow(subject).to receive(:filename).and_return("test_a893.css")
    end

    it "persists a compiled .css file to the public/stylesheets dir" do
      allow(subject).to receive(:path) { Rails.root.join("spec/assets/") }

      subject.publish!

      file_path = "#{Rails.root}/spec/assets/test_a893.css"
      file_content = File.read(file_path)

      fake_css = "\n    body {\n      padding-left: 11em;\n      font-family: Georgia, 'Times New Roman', Times, serif;\n      color: purple;\n      background-color: #d8da3d\n    }\n    "
      expect(file_content).to eq fake_css
    end

    it "the url is persisted to the stylesheet record correctly." do
      subject.publish!
      stylesheet_record = Stylesheet.last
      expect(stylesheet_record.url).to eq "#{Rails.root}/public/test_a893.css"
    end
  end
end
