class FieldNormaliser
  def self.call(columns)
    column_array = [*transform_columns(columns)].map { |element| element -1 }
    column_array = column_array * 2 if column_array.one?
    column_array
  end

  private

  def self.transform_columns(columns)
    columns.class == String ? columns.split(/\D/).select { |s| s != "" }.map(&:to_i) : columns
  end
end