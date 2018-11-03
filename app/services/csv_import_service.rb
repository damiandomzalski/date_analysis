require 'csv'

class CsvImportService
  def initialize(file)
    @file = file
  end

  def call
    read_csv
  end

  private

  attr_reader :file

  def read_csv
    csv = File.open(file)
    CSV.foreach(csv, headers: false, row_sep: "\n", col_sep: " ", encoding: 'utf8').with_index do |row, i|
      next unless row.any?
      if row.many?
        words_in_row = row.count
        (0..words_in_row).each do |i|
          next if Dictionary.exists?(word: row[i])
          Dictionary.create!(word: row[i])
        end
      else
        Dictionary.create!(word: row[0])
      end
    end
  end
end
