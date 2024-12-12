require_relative '../../lib/field_normaliser'

RSpec.describe FieldNormaliser do
  describe '.call' do
    subject(:normalise) { described_class.call(columns) }

    context "when the column is more than one" do
      let(:columns) { [1, 2] }

      it "outputs both values" do
        expect(normalise).to eq([0, 1])
      end
    end

    context "when the column one" do
      let(:columns) { [1] }

      it "duplicats the single input value" do
        expect(normalise).to eq([0, 0])
      end
    end
  end
end