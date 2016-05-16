class AddToWordOfDay < ActiveRecord::Migration
  def change
    add_column :word_of_days, :spoken_by, :string
  end
end
