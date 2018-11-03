class CreateDictionaries < ActiveRecord::Migration[5.2]
  def change
    create_table :dictionaries do |t|

      t.string :word
      t.timestamps
    end
  end
end
