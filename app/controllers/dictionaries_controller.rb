class DictionariesController < ApplicationController
  def index
    @word_counts ||= Dictionary.count

    unless params[:date].nil? || params[:date].blank?
      @analyzed_date = params[:date]
      flash.now[:response] = "Wyszukiwane słowo #{potential_word} #{checkout_word ? "Istnieje!" : "Nie istnieje :("}"
    end
  end

  def import_words
    if params[:csv].present?
      importer = CsvImportService.call(params[:csv].path)

      if importer
        flash[:response] = "Słowa załadowane!"
        redirect_to root_path
      else
        flash[:response] = "Coś poszło nie tak"
        redirect_to root_path
      end
    end
  end

  private

  attr_reader :analyzed_date

  def ensure_digits
    analyzed_date.to_i
  end

  def potential_word
    ensure_digits.to_s(36)
  end

  def checkout_word
    Dictionary.find_by(word: potential_word)
  end
end
