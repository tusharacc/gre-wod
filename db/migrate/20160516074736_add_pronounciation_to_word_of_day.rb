class AddPronounciationToWordOfDay < ActiveRecord::Migration
  def change
    add_column :word_of_days, :pronunciation, :string
  end
end
