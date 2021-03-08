class CreateHeadings < ActiveRecord::Migration[6.1]
  def change
    create_table :headings do |t|
      t.references :member, null: false, foreign_key: true
      t.text :text

      t.timestamps
    end
  end
end
