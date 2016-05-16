class CreateWordOfDays < ActiveRecord::Migration
  def change
    create_table :word_of_days do |t|
      t.string :word
      t.string :part_of_speech
      t.string :meaning
      t.text :usage
      t.string :site

      t.timestamps null: false
    end
  end
end
