require 'csv'

module CsvImportService
  class << self

    def call(file)
      read_csv(file)
    end

    private

    def read_csv(file)
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
end
