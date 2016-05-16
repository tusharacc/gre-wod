class CreateQuoteOfDays < ActiveRecord::Migration
  def change
    create_table :quote_of_days do |t|
      t.string :quote
      t.string :author
      t.string :link

      t.timestamps null: false
    end
  end
end
