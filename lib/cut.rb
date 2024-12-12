require_relative 'process_lines'

class Cut
  def self.call(filename:, delimiter:, fields:, input:, output: $stdout)
    output.puts ProcessLines.new(filename, delimiter, fields, input).call
  end
end
