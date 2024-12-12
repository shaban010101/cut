class CLI
  def initialize(input)
    @input = input
  end

  def call
    filename = @input.include?('-') ? '-' : @input.last
    delimiter_index = @input.index {|c| c.match(/-d/) }
    delimiter = delimiter_index ? @input[delimiter_index] : nil
    fields_index = @input.index { |c| c.match(/-f/) }
    fields = fields_index ? @input[fields_index] : nil

    {
      delimiter: delimiter,
      fields: fields,
      filename: filename,
      input: $stdin
    }
  end
end