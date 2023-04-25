class CreateEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :entries do |t|
      t.text :text
      t.references :journal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
