class CreateReads < ActiveRecord::Migration[6.0]
  def change
    create_table :reads do |t|
      t.boolean :complete, default: false, null: false
      t.references :book, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
