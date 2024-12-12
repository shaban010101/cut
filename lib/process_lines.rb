require_relative 'field_normaliser'
require_relative 'field_separator'

class ProcessLines
  def initialize(filename, delimiter, fields, input)
    @filename = filename
    @input = input
    @delimiter = delimiter
    @fields = fields
  end

  def call
    output = []
    data = standard_input? ?  input_lines : file
    begin
      data.each do |line|
        columns = FieldNormaliser.call(@fields)
        line_results = FieldSeparator.call(line, columns, @delimiter)
        output += line_results if line_results
      end
    rescue Errno::ENOENT
      puts "File does not exist"
      exit(1)
    end

    if output.empty?
      puts "Check the delimiter provided matches the file and the field values"
      exit(1)
    end
    output
  end

  private

  def standard_input?
    @filename.nil? || @filename == '-' || !File.exist?(@filename)
  end

  def file
    File.foreach(@filename)
  end

  def input_lines
    if @input.nil?
      puts "Invalid input provided"
      exit(1)
    end
    @input_lines ||= @input.read.split(/\n/)
  end
end
