class FieldSeparator
  def self.call(line, columns, delimiter)
    if columns.empty?
      puts "Fields value not provided"
      return
    end

    columns_to_return = Range.new(*columns)
    delimiter_character = delimiter&.split("-d")&.last || "\t"
    line.split(delimiter_character)[columns_to_return]
  end
end
