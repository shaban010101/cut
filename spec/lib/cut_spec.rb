require_relative '../../lib/cut'

RSpec.describe Cut do
  describe '.call' do
    subject(:cut) do
      described_class.call(filename: filename, delimiter: delimiter, fields: fields, output: output, input: input)
    end
    let(:fields) { 1 }
    let(:delimiter) { "," }
    let(:filename) { "spec/fixtures/fourchords.csv"}
    let(:output) { StringIO.new }
    let(:input) { StringIO.new }

    context 'when a delimiter has been provided' do
      let(:fields) { 1 }
      let(:filename) { "spec/fixtures/fourchords.csv" }
      let(:delimiter) { "," }

      it "outputs the first column using the comma delimiter" do
        expect(output).to receive(:puts).with(
          [
            "Song title",
            "\"10000 Reasons (Bless the Lord)\"",
            "\"20 Good Reasons\"",
            "\"Adore You\"",
            "\"Africa\""
          ]
        )
        cut
      end
    end

    context 'when a delimiter has not been provided' do
      let(:fields) { 1 }
      let(:filename) { "spec/fixtures/sample.tsv" }
      let(:delimiter) { nil }

      it "outputs the first column using the comma delimiter" do
        expect(output).to receive(:puts).with(
          [
            "f0",
            "0",
            "5",
            "10",
            "15",
            "20"
          ]
        )
        cut
      end
    end

    context 'when more than one column has been provided' do
      context "when its an Array" do
        let(:fields) { [1, 2] }
        let(:filename) { "spec/fixtures/sample.tsv" }
        let(:delimiter) { nil }

        it "outputs the first column using the comma delimiter" do
          expect(output).to receive(:puts).with(
             [
               "f0", "f1",
               "0", "1",
               "5", "6",
               "10", "11",
               "15", "16",
               "20", "21"
             ]
           )

          cut
        end
      end

      context "when its a string" do

        let(:fields) { "-f1 2" }
        let(:filename) { "spec/fixtures/sample.tsv" }
        let(:delimiter) { nil }


        it "outputs the first column using the comma delimiter" do
          expect(output).to receive(:puts).with(
            [
             "f0", "f1",
             "0", "1",
             "5", "6",
             "10", "11",
             "15", "16",
             "20", "21"
            ]
          )
          cut
        end
      end

    end

    context 'when one column has been provided' do
      let(:fields) { 1 }
      let(:filename) { "spec/fixtures/sample.tsv" }
      let(:delimiter) { nil }

      it "outputs the first column using the comma delimiter" do
        expect(output).to receive(:puts).with(
         [
           "f0",
           "0",
           "5",
           "10",
           "15",
           "20"
         ]
        )
        cut
      end
    end

    context 'when a file does not exist' do
      let(:filename) { "spec/fixtures/ss.csv"}

      it "outputs an error message" do
        expect(output).to receive(:puts).with("File #{filename} does not exist")
        cut
      end
    end

    context 'when the fields are not provided' do
      let(:fields) { nil }

      it "outputs an error message" do
        expect(output).to receive(:puts).with("Fields value not provided")
        cut
      end
    end

    context 'when the fields are incorrect' do
      let(:fields) { 9 }

      it "outputs an error message" do
        expect(output).to receive(:puts).with("Check the delimiter provided matches the file and the field values")
        cut
      end
    end
  end
end