require_relative '../../lib/field_separator'

RSpec.describe FieldSeparator do
  describe ".call" do
    subject(:seperate) { described_class.call(line, columns, delimiter) }
    let(:line) do
      "Song title, \"10000 Reasons (Bless the Lord)\""
    end
    let(:delimiter) { "," }

    context "when the columns have values" do
      let(:columns) { [0,1] }

      it "outputs the seperated lines" do
        expect(seperate).to eq(["Song title", " \"10000 Reasons (Bless the Lord)\""])
      end
    end

    context "when the columns do not have values" do
      let(:columns) { [] }

      it "outputs an error message" do
        expect(seperate).to be_nil
      end
    end
  end
end
