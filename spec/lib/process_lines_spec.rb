require_relative '../../lib/process_lines'

RSpec.describe ProcessLines do
  describe '#call' do
    subject(:process) { described_class.new(filename, delimiter, fields, input).call }
    let(:filename) { 'spec/fixtures/fourchords.csv' }
    let(:delimiter) { ',' }
    let(:fields) { '1' }
    let(:input) { nil }

    context "when the file does not exist" do
      let(:filename) { "jjajaja" }

      it "outputs the matching lines" do
        expect(process).to eq(nil)
      end
    end

    context "when the correct attributes have been provided" do
      context "when the input is a file" do
        it "outputs the matching lines" do
          expect(process).to eq([
                                  "Song title",
                                  "\"10000 Reasons (Bless the Lord)\"",
                                  "\"20 Good Reasons\"",
                                  "\"Adore You\"",
                                  "\"Africa\""])
        end
      end

      context "when the input is not a file" do
        let(:filename) { '-' }
        let(:input) do
          input_text = <<~INPUT_TEXT
            Song title,
            10000 Reasons (Bless the Lord),
            20 Good Reasons,
            Adore You,
            Africa,
          INPUT_TEXT

          StringIO.new(input_text)
        end

        it "outputs the input" do

          expect(process).to eq([
                                  "Song title",
                                  "10000 Reasons (Bless the Lord)",
                                  "20 Good Reasons",
                                  "Adore You",
                                  "Africa"])
        end
      end
    end

    context "when the correct attributes have been provided" do
      context "when the delimiter does not match the file" do
        let(:delimiter) { "?" }

        it "output the same input" do
          result = ["Song title,Artist,Year,Progression,Recorded Key\n",
            "\"10000 Reasons (Bless the Lord)\",Matt Redman and Jonas Myrin,2012,IV–I–V–vi,G major\n",
            "\"20 Good Reasons\",Thirsty Merc,2007,I–V–vi–IV,D♭ major\n",
            "\"Adore You\",Harry Styles,2019,vi−I−IV−V,C minor\n",
            "\"Africa\",Toto,1982,vi−IV–I–V (chorus),F♯ minor (chorus)"
          ]

          expect(process).to eq(result)
        end
      end

      context "when the fields do not match the file" do
        let(:fields) { "20, 21" }

        it "does not output a result" do
          expect(process).to be_empty
        end
      end
    end
  end
end